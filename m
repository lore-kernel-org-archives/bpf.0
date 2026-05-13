Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3793A6F1C;
	Wed, 13 May 2026 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674973; cv=none; b=LFxFyBmsskMqpXbUwftRzXyeCJY4Nl1ERTFOBgWFvCe/EnYzlp+aAUTgCD6ulUATzE1nERsQ4fD/OIHkB9P2x+rQZuHvK13416sY6zxdfcVpTnXGnDUUgucPE+x5ZPojsE0jUQ+oA/hpwj/z8q2aYqmcChKUGL0kLsNacKUhzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674973; c=relaxed/simple;
	bh=KVYhtI5apRU7KUdUKEM1I55Nu8KdDkMKATLFzD1Nelo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWc0KdYNzXHpQ/MTPRyU4iGwRi5ceISUAgP8mJH2CE7GSe3pWwsKtJ12VguIxq9meHAseZJye3CLXaDoaHH9LBEwOFR5KgRSL0DWoMafmUT9sVcAUbVLUfalHVREGeoxLalzgHB4Bt0P+Hhh6ixx++q/JRJoTbolX6IH8hnvPPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUgRYbC4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUgRYbC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB9DC2BCB7;
	Wed, 13 May 2026 12:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778674973;
	bh=KVYhtI5apRU7KUdUKEM1I55Nu8KdDkMKATLFzD1Nelo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cUgRYbC4Z2sAab4AdWsSW9R0IvscokW2tfzePrjBirIjwifbgEPCt+1ONLHWzdFoW
	 Embgjr3mFMNWhfog87VvBAOOF910oZwx8KOzMwsUdkjj5eZ85XvCVaIrIQ/aUsbUGF
	 sfmJFwV3xXK/zff+vdVCTKEksS0ZvWfXp4daMpGuhHt/ctbj9mhPA1VBZmTNdsSl1I
	 QgViYuv/1zG05axJEg/dewU60JtT5RckVXBfMwOqsQzzHsmujezCme7mnp4c1N14Zf
	 A+kowqwBgRbCiPCztSD34mgth94qoQYAwWcMzgfbZxv81TxobORdOVZDvJsHVmXQZf
	 e4uHy/4rz0ESw==
Date: Wed, 13 May 2026 08:22:49 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Indu Bhagat
 <ibhagatgnu@gmail.com>, bpf@vger.kernel.org, sashiko@lists.linux.dev, Heiko
 Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v14 05/19] unwind_user/sframe: Add support for reading
 .sframe contents
Message-ID: <20260513082249.51238d75@fedora>
In-Reply-To: <5e7a8a95-fee6-42f7-9c17-a8c1684240ec@linux.ibm.com>
References: <20260505121718.3572346-6-jremus@linux.ibm.com>
	<20260505185932.C708CC2BCB4@smtp.kernel.org>
	<4e5d51f0-8f4c-4a07-9141-8b26d2c90fc6@linux.ibm.com>
	<20260506110142.7b2943d7@fedora>
	<5e7a8a95-fee6-42f7-9c17-a8c1684240ec@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 15:35:09 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> 
> 
> IIUC config options that get selected should not depend on.  So the
> following would not be ok, although it seems to work?
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> @@ -495,6 +495,8 @@ config HAVE_UNWIND_USER_FP
> 
>  config HAVE_UNWIND_USER_SFRAME
> 	bool
> +	depends on 64BIT
> +	depends on HAVE_EFFICIENT_UNALIGNED_ACCESS

A config selected by architectures should not have architecture
dependencies, as those architectures should not be selecting it!

Archs with both 32 bit and 64 bit should do:

	select HAVE_UNWIND_USER_SFRAME if 64BIT

And no arch without unaligned access should have it selected.

> 	select UNWIND_USER
> 


> 
> Shall I better use BUILD_BUG_ON(!IS_ENABLED(CONFIG_...)) instead?  Would
> I add that to all functions that are affected (i.e. __read_fre(),
> __read_default_fre_datawords(), and __read_flex_fde_fre_datawords()),
> duplicating the build-time error message, or would I better introduce a
> dummy function to check this precondition (and 64-bit arch), for
> instance:

Yeah, that's a better idea. You only need one BUILD_BUG_ON() in the
file for it to have the desired effect. You don't need to add a dummy
function. Just put it in sframe_read_header().

Thanks,

-- Steve
