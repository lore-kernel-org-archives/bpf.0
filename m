Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9216383984
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790661892; cv=none; b=YgoaR463Z7i01t4K2QiYIG08LVn6gOKR+OWBvu7z4Ij+JxgIXJ9Gy60k4/d4CtuN1+V81C8SSZorQavMtEVF2h/dCtOnLG59sP9idGsnWs0loJG+yRXVyGjAcPnjc3a2i3xMwZ09lWIV298YhbLsnPYQ+qaTAP0PX8lzmvvyxEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790661892; c=relaxed/simple;
	bh=59sBPfFbQu+SgkZjBownU9qNQaLofeQyVGSUdr1zzYU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=jGTNc1jczaaZxHBPwmRN222V/DEl0/3bvjMM1k34eLD1jJd92LNQ2rKxKrP20hcjzsuwSyQlmsrv5EC4zRoBOo1Hd3vhnxdZgBQs0492j0dMKZNrkNlUmbkKSanxOVy51MdPZBicjA8sz+W2K5PAvKdMnwRm/JS9nJkLxX5xil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKEDrVRQ; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKEDrVRQ"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so1368254a12.2
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 23:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790661891; x=1791266691; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=59sBPfFbQu+SgkZjBownU9qNQaLofeQyVGSUdr1zzYU=;
        b=rKEDrVRQL2g5W3+xkiRfba4dUvfWfIfjPv2D5FaNqPZtAmfZ6lOWn1qzJHneV9rSlJ
         f2tiBnhpSJ0y4acut5F5CTmxS+avXz3xWu1ly1+B4Nkc9+Wr7FCrcspA1WMJx6tFHGQm
         4OIFa3UloBzwr89zRAl43aX/NL/LI06eg9qtmflHbLgYS3wnvRw+kMTS+neTi2DPejjS
         GmEW/El3KJjJdXoweZ9MUE8GJGhxKNV9Wcf4cpV5IeBZw6bbLSRlZVfTkzva1EFngIJ8
         u2APFFMWGlr5YLM7247uHdkHW0Qh2WiHnNyUueZMzFq+tE4/ET4nEBRlhkCd+fvjMmIm
         PdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790661891; x=1791266691;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=59sBPfFbQu+SgkZjBownU9qNQaLofeQyVGSUdr1zzYU=;
        b=Sdub0gnHyQ2R/f3+j2eiLqppbBRRv651SQgV/1i2zvFTt+sYDYI0LNF53Jw2WBmGKf
         UpGy0LLZ/V1D6dk6wTC2H02miHDaX8hbQNXtqK6jzgMhZnG2QArdyqm2+vBO9s2RR6dy
         suD8pOdKV2Q/eyj6TD+8l3TXYQCLs1Xs0/bZIs6GV5wbXhrrQslQAwv/J+d1J238O9VN
         VBJk2lt4sctAJ6jM5Mx0PF//UwqllTDjGX82cWs3xzD2C5o3UOqYsNOqVZT0ri+iz88/
         OojynXuo/UPk6MAVjJDdQAMXQc+iGJm2OoxBQvlETUjAQLdH7LWGMpt/B1kMNtddfO3x
         rI5w==
X-Gm-Message-State: AFq9FYL//0Ihm6rsJfdYTcCJeLw3ChrIpgYrdix85JESWPR84KqpptyV
	DpFcGKQCfPtJlBoIwlbRexF29FQZ7F3IpR1ooty5sYyi6yQAbdFvnaKj
X-Gm-Gg: AYBFou0mDJAERiJvFUja7KBwo1M015bdGLMbQ7THfrSEe37/eazg/nWvnvYTuMxmphK
	d14++y3v25yljILAkuJcBtNK8A89VAyWYpV9Hw9VNpK9KDHlgQs1khE6ngBy+vimOa1W0tmlsq6
	rU5OUxrJIHL24upreYUIK3Kc/XI2Jwqi3QyKbtAm9QWE2DOL/MId0aH5pfueM5rUkHT2p2MfsxD
	995vZpDRcCNjuEqHBPoeU8+reV2iZ7Mryx2ijzPf+5j9g0+mGxGlDtSFCabd6BTRUQ4FQcwIEok
	IQht6nQQXgx0SJgURS3J7WjWxXRhhhvVKHR3gCKFSTNUOZ7iHO5QJcPz/qoL0KOE+rk72hriZn9
	J5Q8SS4k9A54pib5AFp0tV34RU6XyrFCmKEncpIo5WMEp5yhqrOW61gJz2EacFmtjxnUoEzB9Gk
	yHksUoYcCEQkQ/705kfg4xzuTVam/Qscr9FEdSKqdHJdNeg2EqupE9wx3vu0Yv2WEjHSHaNyJXM
	gH0ZQPhqAneOzB2bHL4EjMDA6QZLyGhad1t8w0CRWnBUYg0vLl5wb3Ax5DfGxvNcHnGOJ+FjSxh
	VX0=
X-Received: by 2002:a17:90b:4b86:b0:3a4:a477:62e9 with SMTP id 98e67ed59e1d1-3a4a47767f1mr632577a91.51.1790661890748;
        Mon, 28 Sep 2026 23:04:50 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498d8ee5esm1131839a91.2.2026.09.28.23.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 23:04:49 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 06:04:47 +0000
Message-Id: <DLRKNUWD51KM.3URQDVOWL0BRY@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v2 00/17] bpf: Indirect calls of bpf subprogs
 (callx)
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 <patchwork-bot+netdevbpf@kernel.org>
In-Reply-To: <a25b9150-55ba-41ef-8de9-0067b4576278@linux.dev>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com> <179022901639.1337807.12766583921039284951.git-patchwork-notify@kernel.org> <a25b9150-55ba-41ef-8de9-0067b4576278@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 28, 2026 at 04:13 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
> We're testing clang 21->22 bump on BPF CI, and something is broken
> when compiling callx selftests:
>
> 2026-09-28T22:12:12.4226025Z error: Undefined temporary symbol
> .Lswitch.table.call_by_switch

That's a bug in llvm 22. Not related to callx.
With -mcpu=v4 BPFAsmPrinter::doFinalization() is supposed to remove
private arrays of blockaddress that were converted to gotox jump tables,
but it removes all private const arrays of pointers.
clang turns the switch in call_by_switch() into such array of
pointers to functions.
Yonghong fixed it in llvm 23:
commit 9fc458a1d95b ("[BPF] Fix erroneous removal of non-jump-table globals")
It landed after 22.1.8, so no release of 22 has it.

> What's the requirements for callx? Does it need bleeding edge clang?
> If so, let's explicitly skip relevant selftests for clang < N?

No. clang generates callx for years. clang 21 is fine and 22 is fine
with v2 and v3.

I'd bump CI to clang 23.

A bunch of other tests require __clang_major__ >= 23 already.

