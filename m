Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1702EA171
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545951; cv=pass; b=nNyohqf4C+gxH+qF+PfJ5z7n+n5z2xyYP/gY83gAXICPkJzHfujZOpHn5BOO+A+xQUNnDhlFN2F51Vfgg//PcqSrHyZUhngY9bPglHz4ZYwbOdCWWDOKq+kl5vU8lPStAS+uwJT4lwwPBTYY44GK5TULvUBkdXqvdfappyLIt6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545951; c=relaxed/simple;
	bh=F/xumjagaO7uiqFHe3JFaFUs9Sdofx73Q//yAlceRdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNVPWxAyngbqAMDNw4lDI1HwA+AYlhpWLzjqEirD2QZf0nEPdPCKji2vwufzT1gJdtH05BnTx+f7aVM7IxaGLS9Wl0B7xuvX6H7VppQThZH+TmF4nzJLfzd026OsZByLe2nDFB7M/Oz0yVpXTrNO106L6kCalr2o4Zgr5G592cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZ2PW/GI; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZ2PW/GI"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7e86d46b02dso39391107b3.3
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 10:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781545949; cv=none;
        d=google.com; s=arc-20240605;
        b=cflWR5Y/jWwdZBqGHHdzWPHj2ifDih9mv3nzVSvitCrSmugsuV7v+RNqqHvN8+O17B
         ZZy+CdMfSzgAMwalOleMDKho/rRGgPedl7hAoY1OQKPh0m3wotugxVzWfd2Sq/R33Sy8
         0IkOHDxa2zzKL6dX02mkgLf2hrFHC0FqWRlygxEkdGKBlH2wwkbXwFoB+Vbynkdwt9sT
         RExjTjk6cKgddvGiOFm+S+QrVIzD5Sy2cyWge2cKZk8iIfc19djTlAgl8ZgLTz2SJAq8
         udNPOHqMBEi7X/Ejf0E2HMpZNw6+22uoCP7O0cnHhNqILIyRRheS+wP/vJfXvXeLfMWY
         A5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F/xumjagaO7uiqFHe3JFaFUs9Sdofx73Q//yAlceRdw=;
        fh=BO7gv6Z4ZLb/IiN2r5k1V5iJYTmFbVMnFSXYlhZjcWw=;
        b=PtqoF3jDx47oRAAFoq4yBneFkkEmhWQh6JQF/4efskkjAHj4DViNzjzNQZcffFOVj9
         A1L8Mi+itVtLgSXrSvcO8G2XAQHukGmqjSIMY0JzlDuGe0pcuoTD4YcJyjEHiAN3TTzx
         4rGlLkIzJbIHFiQu82BcYNn/qlvQelFRB21l//OJO5Hqyb8lxsxDWHQ+YcihcjWouc8v
         zDV1r/HnE29qa4MTYh92h+Xo56D6nKLioyXjJpj2LLsIqA/zRT09k63h3J7aXmc3uznq
         XKBnOdPEP1uSVLmWyC/hFR5Kd8/LPqKkiAztZJ3FMAunwsgvcYy/G4EaZ9med+k5yoP3
         fVyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781545949; x=1782150749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/xumjagaO7uiqFHe3JFaFUs9Sdofx73Q//yAlceRdw=;
        b=rZ2PW/GI1wpOhbojeizmHOynhwPomxWsvdvzBHZlHLHzSZx6Oo/svub6KT2FXfVOlv
         D4KFOUU2IjgL/l4YF3Ghyz+b2LaT8+jxMCM38SUU1WGBWd+lcFX5sDnCkINw66AN70Sr
         mfUqTzUiaphYZYhlgXmT/75cu+j/Ke2StSIecEIiiT5PmIUCGUhK8S8Eos2rqfVssVaX
         ocHeuec4slM4FIMTfdVHvvkq/RAQK410VneRvYkmpt1koxOs0mPdk+SSIcJjvEc0k+dH
         c0qJeGSnJN+3URYnbT3LhMQLZkK4ZLTFVMY3nh9pYs/u82Ocwm2YICI6OcL16n9R7s+5
         BKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781545949; x=1782150749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F/xumjagaO7uiqFHe3JFaFUs9Sdofx73Q//yAlceRdw=;
        b=Y0UosiN8hWv/Hc581HetPFUk9QiIC52lXl5rOnoNAqWxgFvEbzOh7zgsZwGWa1jM3F
         1SvXkjK7DLwaIP67n2RB+rFh7/psQ5fyJaKJwFQc4ylo598JyjKF3nMpsM5lJGL2JEel
         wHRMn5pVbtB9eF17cVhcAKi5zWBg/5Q8lf27oEUB037aMQzFsJe+DtOTd2i8MVSS1XzF
         +QGDVX/x1a1HxyjebfRlFl0FktmMPCkulCwdA1f2A8/4hxjsWbv2fAP7ofzxCKksTUul
         m+wsErBpvRxl9IznZYMuK+2jELlfbb5qlImWrOBPbmp569rNv9y/cuELJ3LlRsmtDswb
         I3gQ==
X-Gm-Message-State: AOJu0YyQr0mmu0NdDqQdwc81RsK7pNQbVk4qHS5BPc1XWwbOeguIshSE
	P6crLhrtSvVKG3/xEGQKO56aAyBJPYRfpNRwXZjorJgmi13nB4UEurPYDef1gHo3tBhsUhO1PjO
	fWPEoMas/FM+YVyd+W/SYA07PVId5Lu4=
X-Gm-Gg: Acq92OFJttliDJ7W8UrDW3jHqhGqWREK0hzg4n+bQ408U/btfD5i8UgSaL4YbgVrzKB
	6EqEAIb9CgypNJ/FlFloiKmed7+b4S0PbX3JGk8slEdx1MIMC3KQfKUTfE8+Ly6wTWiSzOM6wcm
	4cf884Sax0KpbXWgu2SJtVDnOMWAAoFt8r/9YSWCMLs4Swjc+ZIQB/rXoyfvH8k3S7GmjuqxUCv
	SMhA5vpfWohsaiqP7hw4oauN+jbbyhwRV7D3n3Z0znk/9CBvrl6lPa4I5fq2n4gFlojjuG4ahwk
	KqQeQKAYm42JBlWF5hZJVI4DaFagFGePHQnwD+lBQ7ViwnvGyLutMZJr4RbTEBTYMYC0fR0LON2
	Yxnh84MdNSW9OGKf45otfiX2eaY73OYxN5EE=
X-Received: by 2002:a05:690c:4902:b0:7bf:55b:8f9e with SMTP id
 00721157ae682-7f8c37d34d2mr109748887b3.28.1781545948658; Mon, 15 Jun 2026
 10:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781535194.git.chenyy23@mails.tsinghua.edu.cn>
 <cover.1781539813.git.chenyy23@mails.tsinghua.edu.cn> <fe46367f8e2c2ae81e626e71d200dbfc3e7d644f.1781539814.git.chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <fe46367f8e2c2ae81e626e71d200dbfc3e7d644f.1781539814.git.chenyy23@mails.tsinghua.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Jun 2026 10:52:15 -0700
X-Gm-Features: AVVi8CcE68diEL16uraQ78pM0AjOCxoVdQa4JF0hQhCDysKpd0zBs9sA1Nf7WiM
Message-ID: <CAADnVQKivwK1aBW-EH_-x83Z1L8HC0ceUau3_SLNLyzYr7Dszw@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix packet pointer invalidation for skb
 dynptr writes
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 10:49=E2=80=AFAM Yiyang Chen
<chenyy23@mails.tsinghua.edu.cn> wrote:
>
> skb-backed dynptr writers can mutate packet data, but not all verifier
> paths invalidate checked direct packet pointers after those writes.
>
> bpf_dynptr_write() handles skb and skb-meta dynptrs in the normal helper
> path, but global subprogram dynptr arguments are verified as
> unspecialized local dynptr pointers. Treat such arguments as possibly
> packet-backed for packet pointer invalidation.
>
> Carry that possibly-packet-backed state through dynptr clones and dynptr
> slices. Otherwise a global subprogram can clone its dynptr argument and
> write through the stack clone, or obtain a LOCAL-typed dynptr slice and
> write through the original dynptr, without invalidating packet pointers
> or slice pointers that may refer to reallocated skb data.
>
> Global subprogram summaries are computed during CFG analysis before
> register states exist. Add conservative static CFG predicates for
> bpf_dynptr_write() and skb dynptr writer kfuncs so caller-side packet
> pointers are invalidated after global calls that may write packet data.
>
> Keep the normal verifier invalidation precise: helpers and kfuncs still
> use the checked dynptr argument and only invalidate when the written
> dynptr is, or may be, skb-backed. Source-only dynptr arguments remain
> unchanged.

Nack.
Nothing to fix.

pw-bot: cr
