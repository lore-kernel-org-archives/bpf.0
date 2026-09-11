Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B436D9F9
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140491; cv=none; b=MBD6tysjw3K8S+eqXN2/oXw+Pq7FqCCAveQOEVKjcYUjlQrGz8WugTHG+com5psVJ4mwqGC2xbwel61mZhDd63zWVt/OS2V5Mj2fFonJMvlqIMMlp9YthfyGLGib22W72F3VXATM8Wcv4oj/s56WBsyYZZVZ/6Y/TeUaoKOD33I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140491; c=relaxed/simple;
	bh=FhC1BGc+izFGRSVhsr6TbpR9BgsKGiF2SuSQ1pALooY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lTsQb/JVgoE8Rexp1VQwALvul5KRtUAZAvJ9ZbWXnXGq5grvvJxTAPt9vQs6XNfiFsAPBpKhDKNmSkeWbYDsFZ1umDE1/x16QTXixFujSdioXUfGUs57y7V10gvfEJZT1C76HNwWZmCfzT4hfzQTJiv/ND+Ui8mVh1MQOT2s5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryUTerWU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryUTerWU"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8200b55dc47so12022147b3.3
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 08:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789140489; x=1789745289; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wQzcuFPYkAadTcMKWgFjkOZlpHbtRvNH6B7KXfZ46WU=;
        b=ryUTerWUF3R4IkMvaNV1k5u2/OHYEhgHfcxKb62+78w/vZaarAMoev+UPQjMVCcZf/
         D31h/Zoy7/rPNKtqflKdVWE2lN/f9sD8ChZyWDsxNehadFqAPdcoT9bW3ClFxv+kK7Cq
         kCDYFj4+3vCbmWmqvBcUIvVO2lDY0axCsuqABEO9ig+bJFhDfgXfR3BM5iK8Gds2a24s
         S6VY/pd9SA6pHDDzqTOV9VIWwo8Y04l4FMZrnRd09W7XMdoN3h+EmZd9OB1mFnVbdtzK
         xr/+dq0bE79gM1IjOFRdVc61EE9PRu5VJp0mNDGugjIAz2cSkufFJvZ+uOHH13ri9RlU
         N25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789140489; x=1789745289;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wQzcuFPYkAadTcMKWgFjkOZlpHbtRvNH6B7KXfZ46WU=;
        b=R/tTYqZ70CfKH4qCfnfZCMDY4DzCdu1T6Pq3VaUW1gIRY1EiZ8n6nTP7/BgdDz4nD0
         hMgIZ7asbVv+/tOc7wyvTY9eFKRaYJwroOgPEYqErsQkBSr3iVR1rgii00u4TLyNn+v3
         ufe/4hglgzLSBmA/7DVD2s7z2aI+c+8mHeTmyFzfXf3fyhXxDkJ38Bz1O9tiIV3Gp+9j
         iOhPbSDg2Ma7A0wBoQMlr9T/lcTWPV4gtg12qYK//3xoK4MvUQGoA5dcHf9xABonVZR8
         xDEGP5SNLGVKB18p0OjrGxTxbMZXL0a9QWUd+R+9Lc5WWG9XG2kByWIGlNG7Fu9Iuqtk
         JzuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIoDPuTS2FCLm8+92Vw3/AaUinrzht14ezyfpX1f7ZcwYhrjzSSCla+zpVI3CPZaxi9fA=@vger.kernel.org
X-Gm-Message-State: AFuF++mdHp/TtWA0P3/XWH7r6Sq4/CNE4Ciw5spbgGvxAzmyPQRvf2SL
	Ll0RIwok1Ji2oOUOf4gtSFbjSHhxfVXR5HVPLucBlqVjmYfTQDQCMW5a
X-Gm-Gg: AYBFou18i06BU9/+bbMB9Rq32ZUvouBdITS/WC2yZ6Fl/+166QnHZ5D58x44/ez5EkK
	hGo4/JwqycFlTL4L1toL2CKoKrBqnRrtlU30tEqmi0iX0iXWk66gxPRtRGqqWYcMMRmP45lV/zn
	Y8gO/k79zFFAfSZruZWOwh6qLw64WW6R/k9IOLABjgeyyQo2cd4LY7BFgu+0ngcTGFD0l4MyfbE
	sM9OKR6RmT+quZkellHs3v5+yQ/hZDtU9JfZKi1n496e+T5BDvQ/1PU61LHhwch5obCDR7N9Qnd
	PAfGSiaRGX0ZMJE6NjlUc3GzjeaRlv/8B6iLh/bEEYa8S0A7vPGkgx4ksqVJPAVdR7gmpaLCh4j
	GmtcxlBIs05z36cfZwKm4gvBNfur+vMESkjc6SYp30a/+ohSPTxooHTbPNtzwiOL+lsZdn4bpdq
	m2YcH+/9M/eVpltmkoZVYpg7JLJcyVJSlWgP/GBLBezYcPNPrsnHLnA72FhPG3Zu9H/jUDImLHk
	ri5XdoHKD/ijodZCj9Q7aXes1EL773SFt1wXRx1ia4IF1rt38UmmGYrDLfaK3jB/g==
X-Received: by 2002:a05:690c:660a:b0:873:5c6b:a2f7 with SMTP id 00721157ae682-884b23029e1mr17446467b3.37.1789140488900;
        Fri, 11 Sep 2026 08:28:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-884876e5780sm11951597b3.27.2026.09.11.08.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 08:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 08:28:07 -0700
Message-Id: <DLCLDD3KN3WJ.2PUS28BYG2QVK@gmail.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <linux-kernel@vger.kernel.org>,
 "Aohan Mei" <henrymei@tencent.com>, "TencentOS Corvus AI"
 <corvus@tencent.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Hash lock addresses in rqspinlock violation
 reports
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Aohan Mei" <ljp1205831794@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260901114755.1165703-1-ljp1205831794@gmail.com>
In-Reply-To: <20260901114755.1165703-1-ljp1205831794@gmail.com>

On Tue Sep 1, 2026 at 4:47 AM PDT, Aohan Mei wrote:
> From: Aohan Mei <henrymei@tencent.com>
>
> bpf_prog_report_rqspinlock_violation() prints the attempted lock and
> every held lock with %px, which expands to the raw pointer value.
> The report lands in the program's BPF_STDERR stream, and that stream
> is readable through BPF_PROG_STREAM_READ_BY_FD with no privilege
> check on the read side: prog_stream_read() only validates the fd
> with bpf_prog_get().
>
> Any user with read access to the program fd (a shared fd, a BPF
> token delegation, or an unprivileged child) can therefore read back
> the raw kernel addresses of the rqspinlock objects, which are
> dynamic allocations whose placement depends on KASLR and the slab
> layout.  The verifier-facing log path gates pointer printing on
> allow_ptr_leaks; the stream path has no equivalent gate.
>
> Print the ptr_to_hashval() hash of each address instead, so the
> report still allows correlating the attempted lock with the held
> locks within a boot, without exposing the raw addresses.  Fall back
> to printing 0 if hashing fails.
>
> Fixes: ecec5b5743bf ("bpf: Report rqspinlock deadlocks/timeout to BPF std=
err")
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Cc: stable@vger.kernel.org
> Assisted-by: CodeBuddy:Kimi-K3
> Signed-off-by: Aohan Mei <henrymei@tencent.com>
> ---
>  kernel/bpf/rqspinlock.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index 111ec80ea958..5721dc1a9577 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c
> @@ -16,6 +16,7 @@
>  #include <linux/smp.h>
>  #include <linux/bug.h>
>  #include <linux/bpf.h>
> +#include <linux/string.h>
>  #include <linux/err.h>
>  #include <linux/cpumask.h>
>  #include <linux/percpu.h>
> @@ -673,6 +674,7 @@ __bpf_kfunc_start_defs();
>  static void bpf_prog_report_rqspinlock_violation(const char *str, void *=
lock, bool irqsave)
>  {
>  	struct rqspinlock_held *rqh =3D this_cpu_ptr(&rqspinlock_held_locks);
> +	unsigned long hashval;
>  	struct bpf_stream_stage ss;
>  	struct bpf_prog *prog;
> =20
> @@ -681,10 +683,15 @@ static void bpf_prog_report_rqspinlock_violation(co=
nst char *str, void *lock, bo
>  		return;
>  	bpf_stream_stage(ss, prog, BPF_STDERR, ({
>  		bpf_stream_printk(ss, "ERROR: %s for bpf_res_spin_lock%s\n", str, irqs=
ave ? "_irqsave" : "");
> -		bpf_stream_printk(ss, "Attempted lock   =3D 0x%px\n", lock);
> +		if (ptr_to_hashval(lock, &hashval))
> +			hashval =3D 0;
> +		bpf_stream_printk(ss, "Attempted lock   =3D 0x%08lx\n", hashval);

No. This is not necessary.

pw-bot: cr
