Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E4402BA3;
	Wed, 13 May 2026 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675445; cv=none; b=PRbheDzgrKZtWIAvd1itURIi3DV0jpTvQcRbssrqcyV+jgVdWjP4VM8srpz8vExJbezF2FUE2VogagGOFf53SFmpmARQ0nE3xsQmsIyZ1hmxvGNI3+oPJouW4zryWmt1B/q3ZM+USplxT84RkGmDDuW8ydd/m0Yu0xxQCkdipqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675445; c=relaxed/simple;
	bh=tgpoOZoItsP61uk4Hhb/l62EdGsyDQF/ywdNYaZLknw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDa/9BZWuKLKdDRyRnT2YluMnkZ/n7mzt0Dnbn09oz9iM1d22mb+l0y6GevnN5vlmvThUH9HRrdl3CDfLuGE+MCErzMSxpmhL911AsxCXqudD1VNPo5TGhRoCcRCSqpHNrz9nB5OtuhKYuGZMNM66SNwzIVZI/unqpVWa/5PwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCoYceny; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCoYceny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3920C2BCB8;
	Wed, 13 May 2026 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778675444;
	bh=tgpoOZoItsP61uk4Hhb/l62EdGsyDQF/ywdNYaZLknw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YCoYceny02tLeuqTr67Nt/r7cbdpkqf90UcUKdAsGQV9CGty3UjkZaFzX2zlJe9b+
	 iKdVK7bgfpvEdcyQR+2RgdeYbylyRND1QIBZy6HZu1DZCh924gOV2e9US5iZZglCVV
	 2BY42aY5JtyF52c0/PL1LChLaGu1LfYJ8i9Hr0wMVFwGlFHmQFlMANHMMPtZdoD/EW
	 DAMaBuYLr5aEHPzyIv67QNuyK2Uuvbb34XPFipwU6P2ryLE7bpOMMfrtL6Cn6yNTUO
	 csjvb2QxSZpGG6AByV4yHdA8sNhRQ4QZfL6T6pCu76EVOvK7KSsLla72x4WUx9PKrK
	 i3tuSZNSyF3hw==
Date: Wed, 13 May 2026 08:30:42 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, bpf@vger.kernel.org,
 sashiko@lists.linux.dev, Indu Bhagat <ibhagatgnu@gmail.com>, Heiko Carstens
 <hca@linux.ibm.com>
Subject: Re: [PATCH v14 12/19] unwind_user/sframe: Add .sframe validation
 option
Message-ID: <20260513083042.56087bc4@fedora>
In-Reply-To: <c865e97c-416a-4c3e-8817-9d3f4a8f004c@linux.ibm.com>
References: <20260505121718.3572346-13-jremus@linux.ibm.com>
	<20260505183254.AF63AC2BCB4@smtp.kernel.org>
	<c865e97c-416a-4c3e-8817-9d3f4a8f004c@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 16:23:34 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> Given the wort case complexity of the validation is
> O(#FDE) * O(log2(#FRE_per_FDE)), should it perform the following after
> having processed a FDE including all of its potentially 2^16-1 FREs?
> 
> 	if (need_resched())
> 		cond_resched();

BTW, you would only need:

	cond_resched();

as that checks need_resched(), no need to do it twice.

> 
> What about the unwinding?  Given the worst case complexity is
> O(log2(#FDE)) + O(#FRE_per_FDE), should it perform the above after
> having performed the binary search for the FDE (before performing
> the linear search for the FRE)?

That said, I'm holding off of adding new cond_resched() as PREEMPT_LAZY
is becoming the default, and there should be no more PREEMPT_NONE or
VOLUNTARY.

I think you can ignore this for now.

-- Steve
