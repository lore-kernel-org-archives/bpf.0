Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1BC3A9611
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952271; cv=pass; b=WbtT1LgDKlE5H64rgP5u7MExekbsT3LvH1efr+N+KBwibky1pKY0/h1SgpHGWEuYQWpBrK/QGjpJ94DBYtgYEe9PJVvh6SrrK7c3uDyuaHZqZMtQLw/D+KLAy3Qb1ieeUMd1/OqeWDidPx+JD4NODzlbrZQASdi/5B6BR0BSWAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952271; c=relaxed/simple;
	bh=LFeQAmfI2jWzGO6ITz55S3PHrzjDrm/EzGFx3B4VgN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tb1P1l8z3rqDL+I7sVSSPirmEKILSvmr8CRJM4PQOOkcKy08nac2hlx8gne2HPWL1D8OiWNE6+KCBoCe/93daM5hkuluNwQu3YHQIOj7OWHxdpWYt18p5ewIPePD9RbUTMLDYLY7jDxG7bs9rhGMnefkuiSC6I+zJwA9c71D9OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFWQhHH0; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFWQhHH0"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43988056dc3so728132f8f.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 08:57:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771952268; cv=none;
        d=google.com; s=arc-20240605;
        b=N2M6RlypyBJC3XuMjsfWBaipcbwi7FmLinO8Av5QI/ZzuuVLqNNSJVawONWhJRQM7V
         ul4DnSukJkcgTQgIX6GcglPLhUdMR4Ahve1J/qFvGPCw3o/ckyYBjLZnpYeB8NqTIcNU
         oWdZNe0pxMG2vu2rl3ztzXmL9AfuWwefcXIGWmBjvepLqD0hgEKvR1y1cpslm1VT4HL/
         En33BRpoeiZVY4gZrqYOsCQ6bL/FUvj3SAg8uLMcWQBP3jW3Ujvv5lNypNfL2fP9vAdj
         elwA/ni4nxvL4SDn6hfAelSrBLAyX92on/Fg+Hf1ZrMOcjVFURvNP+aca0svEHWn2PmO
         VCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q/LZ5/ET/z0VwePFl8rmo2+n6v10vbg5EI+OLa8kbxI=;
        fh=x70EScOjwsVQRhqX2lCdqIikeM2OVhsZ8hlCZBMg2Yw=;
        b=VYvuD28oyySHXpNxUak8r89hzY2ewJYF0oSObC7Q7weNRxkHun0Do4ZmqS0/95Dxrr
         GUVvCeIrQJkZOfRGooP7hQOOJ7rgB83Egkj0I3Jx4r+T8cyyYTadS9BXhqrscSCRMhM3
         NPBbmxD0Zx06LJ1WnBxcTxYU67q937DQRkegqDTIUciXxZGO5cKUKmB78d2PZ5TjhmzW
         VIOCkC4eo+UAKeXaIQP/wxE60so3+3YI46dMjuJFxuXg8nhawm5nAoN3fE28qyGZkNh4
         eTb8tFsXRvw12wvExDjiCt5SRvq+hlaTm/hmnkMYiqQrvOeoBFZlwthVfvdjypo7vmAq
         ZzEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771952268; x=1772557068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/LZ5/ET/z0VwePFl8rmo2+n6v10vbg5EI+OLa8kbxI=;
        b=eFWQhHH0tXrcLKY/l/h63HjEN4E5cgnjyg/bZkhOlXYfKPyjIZkb78Oh+FyxIfkTFi
         7fCWJ9wUePTGSYEymzuljKO+kK4YZV2/G6TGaCAeribNY/zxMIMsRqnUq2830SDTHe1V
         BVw8721IvYqBpvRvCRyAENNID9X9SECoy2QUBZLvjMt3s802aD6WlAe+RAEjXlyPJyX9
         3sFlpWc177VtO6PEqk+BEXjirVByVhRu55obFAvNPJaZmchRmZ3E2MbLoPHTq5Y9TYg1
         6S8Zp7Jg5AteW2VqXdkcnkJmWLxRuHT3pxOv111WI+15N1T2GvoFUK5XUe/6G5ogzmTI
         Wu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952268; x=1772557068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/LZ5/ET/z0VwePFl8rmo2+n6v10vbg5EI+OLa8kbxI=;
        b=XBZzJqxEqlXcCDlilApRyTurChIBQD9pte1hgT6NZTuWH4VZDzAt5xg8NJ804PPKlK
         0w5DHpgPh2iMEf2PGfMbMJN1JY9jvbcYxwqMutZ0Ae2ASc1VJPTyRHRJUNAdKXDxhHka
         QiKA35IsgpoQobudnNKkEM/lU1WRidCmDXjMGux9clRW5DmdvIUqiCTCPlJDHppTpOZI
         YecyUtYZ6AIIC36RN6mUuLmvtIzKC/dAnDtmv/hIBpPwuaQfhGjHqURf5ayrHmzRddu4
         /fQdE18pfm4z9isrS3P5aSrX4v7BVz4PvSDencr+YdPBMjGxox6Hl4RAjgeTdQFg+dR3
         Ajuw==
X-Gm-Message-State: AOJu0Yx+JJWJISg6WXN3yLqFQuqCC82s0Vt9/OhIRNpdsHZ0Ete7gE4m
	naDgG1pt6IWbHfMJ174nMuhc3usvcuNcDd/ZsRtajdFjmeUHlO1iVDtv/ZU1+Nk6EBkhXpEIZJs
	zxeKjkSbMozyWZzAYsUGCUCSwbHQAqWw=
X-Gm-Gg: ATEYQzwP4av4lB7Xke1VJdH6RfZ8/z5MaKqBONfit2Jyav8l2beBcvLyMPf4RZxcCac
	NH75TEXlEouppzWS1z0+sV7wIg/JF+Vh8kV/lEeUkIlqz1AnI8XcOxPDnwttmG2MDtuQncl/MO4
	qQBbQ5F607iFbdkk0OEQwhDW0n+Udt2B+BoG0VFfzj3/XvXVx884pKWGUA5DU8TR6IigHOr6czn
	gflPehiYpRb56V3S62FW2G2cVzmMfGkqraHrr/IHgmQCvBCSLWeJqfAvdrZ2Whyc/HFb6NZYtUX
	I2eKhh1VAMFRI+4tUjK6SxRw58tiz/hbVRwqBEtH418Ha272RV537+zlMYNTI/RzLw7yCXv94Zo
	lfrnieKOl
X-Received: by 2002:a05:6000:2407:b0:435:bd00:cb4 with SMTP id
 ffacd0b85a97d-4396f15b2a4mr21141471f8f.23.1771952267940; Tue, 24 Feb 2026
 08:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224154024.12504-1-leon.hwang@linux.dev> <20260224154024.12504-3-leon.hwang@linux.dev>
In-Reply-To: <20260224154024.12504-3-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 08:57:37 -0800
X-Gm-Features: AaiRm53rqopHuRGSK2_nQdOAXTbOuxaGhPPN68Nah4CqapKdrc7UpjUZrDEx1NA
Message-ID: <CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM3Az197eL_0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/8] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	Menglong Dong <menglong8.dong@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 7:41=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> uprobe programs that can modify pt_regs require different runtime
> assumptions than pt_regs-read-only uprobe programs. Mixing both in
> one prog_array can make owner expectations diverge from callee behavior.
>
> Reject the combination of !kprobe_write_ctx progs with kprobe_write_ctx
> progs in __bpf_prog_map_compatible() to address the issue.
>
> Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registe=
rs")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h | 7 ++++---
>  kernel/bpf/core.c   | 3 +++
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b78b53198a2e..2a2f6448a5fb 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -285,9 +285,10 @@ struct bpf_list_node_kern {
>   */
>  struct bpf_map_owner {
>         enum bpf_prog_type type;
> -       bool jited;
> -       bool xdp_has_frags;
> -       bool sleepable;
> +       u32 jited:1,
> +           xdp_has_frags:1,
> +           sleepable:1,
> +           kprobe_write_ctx:1;

Don't you see how much churn you're adding this way?
Every patch has to touch two lines instead of one.
Use
u32 jited:1;
u32 xdp_has_frags:1;

also the bot is correct on patch 2 and 3.
Don't be fancy. Require strict conformance both ways in *all* patches.

And your codex selftests are garbage. I don't have other words
to describe it. They are not testing the actual bug that
your patches are fixing. Think of what you're doing.
Asking LLM to write a test for your other patch is not what you
should be asking it to do. The selftest should be such that
it proves the unsafety/crash before the fix.

pw-bot: cr
