Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF03E9C1F;
	Wed, 10 Jun 2026 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105740; cv=none; b=uZ2M558+WpI73yCqf6IsZt1uacSpEWNp+fvIetd56eEwaBs34989j6/J2cujGBpDQpYuC0tl8AO2jrLq0EAsczR7q2m7NBweV4wFJpK33ZWrUgVkWoQjgZA2oYsuyeS6sOkAgzWVB6DjnPCExZ6xXVQrAnOysICnVJ3FI0EezWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105740; c=relaxed/simple;
	bh=GvWXVWLwRQ2bycvg7mU2B5ogSsTBdZT4F9A0wcMEgbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8x6T6xtelSyMi6U6qMcY6rNBq8Fs50I+iRy7IG2JDZ0yGUZuiSc7aC3OhCBS8TIcUReqvpNpafFGCy5QoFN1STSh8FqfvOPFLaw7RSlyCl28KbSs+iWRhtRHKeDRBGWtS22aTjX5+m29I/QSblIIzyP4qeBsv1o1T7lcpTU40Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZCdm4Yq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZCdm4Yq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAF41F00893;
	Wed, 10 Jun 2026 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105738;
	bh=fZANZX22CMmcnXsZ0uxIrtLQDjClRITx4CzSwp36iag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iZCdm4YqUjZPH2PKl44O05qemfatIhkXPkNJGHC+NtZeGCQxJ79Qd37RiVUg74y/r
	 ywaBWFsm91xWXUCwVsWPt17ndQ0Ds9ekmmBa/ibi5X2ti+6fwIGozMuJRydzmGHPjk
	 LGcfDFvKQVBlanL32t0L0bsxWch1T8+qJVPugJc4vGC+oMnz01ion5YdyhwvKYe+vk
	 FP5fTPXBStJCa02sAEZraPDFHb9FCAusk6oTe43w2Ozl6a96T1rSnRURfl7z7ijRGL
	 e4irYYduOBQIoA12sa/KodPqXGDU/civhVADVhcmct04w8oYTeSYIBGLmLKplRmMaX
	 SV1cfToQ7dpaA==
Date: Wed, 10 Jun 2026 11:35:36 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, <bpf@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, "Martin KaFai Lau" <kafai@fb.com>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <songliubraving@fb.com>,
 "Yonghong Song" <yhs@fb.com>, "Menglong Dong" <menglong8.dong@gmail.com>
Subject: Re: [PATCHv7 bpf-next 03/29] ftrace: Add add_ftrace_hash_entry
 function
Message-ID: <20260610113536.77172ad1@robin>
In-Reply-To: <DJ4LJUWPD2BF.1TY4Z3WY2V0H5@gmail.com>
References: <20260603110554.29590-1-jolsa@kernel.org>
	<20260603110554.29590-4-jolsa@kernel.org>
	<20260609102922.3c489f76@fedora>
	<DJ4LJUWPD2BF.1TY4Z3WY2V0H5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jun 2026 16:43:19 +0200
"Kumar Kartikeya Dwivedi" <memxor@gmail.com> wrote:

> Hi Steven,
> Version 8 of this set was already applied to bpf-next.
> 
> https://lore.kernel.org/bpf/178085644764.273544.8250000589480262551.git-patchwork-notify@kernel.org

It should have waited for my review of the first three patches though.
I like to run them through my tests before giving the OK. As they are
generic changes to my code.

They are trivial changes, but regardless, someone should have asked.

-- Steve
