Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4611E43F084
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784462529; cv=none; b=S4Y3A8ajSgbFWCr4gQ47cD1Ta1NZSyGExEUkQvqe5bN2NX6Rgxa3VU7VvRUCzshe9mDgcaxKw0yFQu1Olu1+zhMuRUrsH22c50jtY9H7iIF5FKUj0PnRo8dDUmsVRP5afrzV1t3JPJc3Dmcp9naCNEtWzSHiYDdeh2NCDLLWfuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784462529; c=relaxed/simple;
	bh=crLKfKSNuXiC9EWrD8lnMeXCugkwlEgYbzJdTF6Ocjs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=M9PnwStAxk6QEXByQUEe5ddjygZxThTf9ypaWeHJhzy7wYN5P2Byd7xXveBOs/88sU0oMLCXYdaQtvDfJK5We06RcrtasW+bJE+x4ywUkwJU3oafalt+aYot3IJ4LicB6+DgJQDYG0CrzZ9SlYaEl5Se8rWbkYgKfihDXhRfae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrlA8+56; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrlA8+56"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-470713a9053so1322048f8f.0
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 05:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784462526; x=1785067326; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZzBSwW8MVDWvYCXQ+ucsCugAcDr4PVX8fEAbJpnAx+I=;
        b=IrlA8+56h05sJw9Ne0+DhzbytuO/6A3JQBLkMqgUhhWYXpkhd2qCO2N9pXBZz22Lo+
         pq5+tuvYs2Rnu9FyvD90ba0dFZkDURqyCFudUXmEvB6Pr8cfOfFgU+aLlDY+c/TOQLgX
         SXPO6+scDdEEOpgjW4sTzp0gTY9wj/JN0zf2oy6HqEcKLEkpgE9TR4qap7aCudkaY/AS
         zPVG0B0rGSfVXZV1peGOl/U6d0R8FdYKiqSRSJ3pF8MA6jF+hJhgW15XtyqnH+JEYcmg
         J7V+JAhcY7kTKQQsUzbE6fhPj2k/TAa7WETyquWzggxKM2iEREu84D+ZmCpTEXYU6L1y
         RpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784462526; x=1785067326;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZzBSwW8MVDWvYCXQ+ucsCugAcDr4PVX8fEAbJpnAx+I=;
        b=h/mer65gajwwF/ZyP3806s48HUWM0KjfkCuV8v3dexGOXFxDWJINHhWIVERU3THMY8
         vzd/iqAdZVU3jE8Zen/yOn3ZRpyO2KDhRRS+b0k4cbBfKLvnKHLuYXwFwVltgmITgltF
         5X2km+XvNuV0XCaH2awJoMOuGMNQiXfabSuhLMg31d6Gn+XCYrpmurXDse/+YiVPT1oN
         +ZFdAPl88bXtkFRWBm0kO7/MWGlu9UBfWo0sNLFFRFiE3wdVUWXz7uRcjgJwr7LrXxYo
         sWubS4AnJR3juck+MM+8MHEg3+OgQzMZf7mbRpg2VwyKWNF7GB8mGEK3k9OOQr1bHcWu
         hP9g==
X-Gm-Message-State: AOJu0Yy40xS48km/W3+y1khPVWEq3s+8ySQHx4FweojeFdk1xjTo60qb
	3UDKd1TpgfjwfJRXeEC+8b54+GWRZwMU9RRNwIBehkalqA6khqjIypIC
X-Gm-Gg: AfdE7clq1/z/w3V7kAt3IHveieZtRRFsjwuoE/TACOvztFcwB1Dxfm5ecao9hhbOGHj
	IXsyCxuqFMD18N9trsi/W6t1ipsI4f1Clx9Wj5K0y0/XS3hRtij6NF9w26ZV7eQu5Op9t1I6oTC
	U41I0p24oBYsmJ5SZ6rEsRzKfX6OPyNSN/YEnNa1RzbSmnazWmK9+OrvmnDYECJQoRynDyMu4KQ
	e3THe5Ab1+Nv0hNzJbCO6GMJXKCn5jcHI+ErbNFSlaKa4/SwrqNtZpTFLh4GcUZ7fNk7CsrTpIu
	Hif0hit7mR+Q23TC0Mn0S9BJAbjsbET3KDHJP8mMFYCaulfwj/sgYpg64BqUPVJaLcjlsDzftAi
	sMbc9PQunFMGW2+fxCxmwN7hI139pvM5e3cj6rjhh/EieDoNS2u7LQd5SBgUFZmrGGZZcfNbDiT
	gbq//wqUQnbwO/PRVuLKAQnX+qiqlYmTojhq4UoYYgbRK0puUVFIowkmbqNwHbkTbkmRtKRry22
	SlU01ErcVy5aty1VQN39NAGkZpaVb7Kfec2oF1OYiH+
X-Received: by 2002:a7b:c383:0:b0:495:48d7:7eaf with SMTP id 5b1f17b1804b1-4954a40bbd3mr67218065e9.28.1784462526188;
        Sun, 19 Jul 2026 05:02:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm172701825e9.0.2026.07.19.05.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 05:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Jul 2026 14:02:04 +0200
Message-Id: <DK2J66UJL9Y2.1CFPFRV92X1S5@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Allow bpf_res_spin_lock() in all
 contexts
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260719113551.1294284-1-memxor@gmail.com>
 <20260719113551.1294284-2-memxor@gmail.com>
 <20260719115625.B498D1F000E9@smtp.kernel.org>
In-Reply-To: <20260719115625.B498D1F000E9@smtp.kernel.org>

On Sun Jul 19, 2026 at 1:56 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [Medium] bpf_res_spin_lock() remains disabled for socket filter program=
s, contradicting the commit title 'Allow bpf_res_spin_lock() in all context=
s'.
>
> Pre-existing issues:
> - [High] When parsing BTF fields, the check for a valid `bpf_res_spin_loc=
k` offset incorrectly checks `rec->spin_lock_off` instead of `rec->res_spin=
_lock_off`.
> --
>
> --- Patch [1]: [PATCH bpf-next v1 1/2] bpf: Allow bpf_res_spin_lock() in =
all contexts ---
> commit 88a844e18ff8ff22c90389d929ce1c63353b73fe
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Allow bpf_res_spin_lock() in all contexts
>
> This commit removes the restriction that prevents tracing programs from
> using bpf_res_spin_lock(). The stated goal is to allow its use in all
> contexts.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 4446f0bde88b5..bb6e16668d0d1 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -17815,7 +17815,9 @@ static int check_map_prog_compatibility(struct b=
pf_verifier_env *env,
>>  			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
>>  			return -EINVAL;
>>  		}
>> +	}
>
> [Severity: Medium]
> The commit message states the goal is to allow bpf_res_spin_lock() in all
> contexts. However, just above this block in check_map_prog_compatibility(=
),
> there is a check that still blocks it:
>
> 	if (btf_record_has_field(map->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)=
) {
> 		if (prog_type =3D=3D BPF_PROG_TYPE_SOCKET_FILTER) {
>
> Does this contradict the commit title by leaving it disabled for socket
> filter programs?
>

We don't want to enable it for socket filter.

>>
>> +	if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
>>  		if (is_tracing_prog_type(prog_type)) {
>>  			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
>>  			return -EINVAL;
>
>
> While reviewing this area, I also noticed a potential issue in another fi=
le.
>
> kernel/bpf/btf.c:btf_parse_fields() {
> 	...
> 		case BPF_RES_SPIN_LOCK:
> 			WARN_ON_ONCE(rec->spin_lock_off >=3D 0);
> 			/* Cache offset for faster lookup at runtime */
> 			rec->res_spin_lock_off =3D rec->fields[i].offset;
> 			break;
> 	...
> }
>
> [Severity: High]
> This is a pre-existing issue, but does this WARN_ON_ONCE() incorrectly ch=
eck
> rec->spin_lock_off instead of rec->res_spin_lock_off?
>
> If a user creates a BPF map value containing both a bpf_spin_lock and a
> bpf_res_spin_lock, and BPF_SPIN_LOCK is parsed first, rec->spin_lock_off =
will
> be non-negative. When BPF_RES_SPIN_LOCK is then processed, it appears thi=
s
> would trivially trigger the warning, which could cause a kernel panic if
> panic_on_warn is enabled.

Yeah, it's not that serious, but will fix when I respin (or follow up separ=
ately).
That said, for now, I will wait for more reviews.
