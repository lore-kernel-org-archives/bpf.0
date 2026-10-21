Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792541784;
	b=DlEdUKLxPRa1RD8DTAG+UnbrOvfR42B7HtQ+YejhXy+z9pRWCW9H0rkRDbUe20wPlloC
	 hh25tdmk7ORp/O1oIf/PR0pHQQxNrK185PNmPjKZ/KJvN+tuNrjQQ0AXsR5nZwfiOZABS
	 EIgVqT/R0DBXIhFS8YmRvlzPNIZ41JhlhvkUz99ZBzTem/v7ot2Ehk4TIBNUNsVkkMORJ
	 k2rgJdY+f6joH4ISYN0Y6VCAY0Sj7gdPMXQUb4/2NL6qLRHiSxHStLTqfcJkDOuXK/xqq
	 Owdfzo9gBnGBJWUTUW/jWxI9b1XGOsCKdMmulMbM3thar3OFAwj/BrGORUCHpqLkGkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=JUSir2q5BLuFZXQHqg/6Fwc618wXrCwtXkLVpmVntcg=;
	b=zVBgpT+WwnuapD4IvC2wWhCEj6NKvGRmbDHcFHBYHW71jzXn8tfXLnOtJ7KV7XKUEzie
	 n4SfPoNtvaA+A10aK4QZoDfSdlHrjMI0szxl27TCuEAD/oS2paEOLgzr9OUIRc4yKh7Bw
	 AdrytUMl3AXgwE0eEBkciSayPEG4XrIXGe967lz9XTlwP56l4+fhL0NY+n6QsEPH0++DX
	 tKTwG+EeixJXe0nn6UUi4iswLNlaPzyHzZQcqkuD6MmytIuLm32AjnKK5ZNoHDVnkAPnb
	 nAPxSBjfvjrixvo2VbgecZMFFQWwisHVgmZ3c6ffNJRszwGp1HmriOD4F1rM7Lc7SHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j1laCVTL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E37606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E37606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j1laCVTL
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8acda240937so1582507b3.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792541783; cv=none;
        d=google.com; s=arc-20260327;
        b=GC4MFvmwGiXiDAxuLnxgM5mRIHc0MP26ZhgzIKM7QVGoLn2sblW6Ibi/GTNG/Hh0ho
         IPN+UYpJOngtcCgNDvRhzwwKH64aO6Sckb1cmHrAH0oScMUJ8HzXkFzAwa7UqyZinTp1
         mwiv73b66Clwo1Ge33zndwb9gG0gRii5HYSpIZqfGNcZlVyKQ+xZxy+k/1on7KcY9ES4
         KT7uTDGtG2cCAypnsIiEYA5vLDBQvPXd6sp89tHAiVtzDcq0RH4AnHqXucDSOS3E2lCS
         kPopyax+8TfMN4nHUelrTVyFP+V5rShIeUSg07p/HDBZunrw5L26V3CBj6hsyGdclwsw
         RCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JUSir2q5BLuFZXQHqg/6Fwc618wXrCwtXkLVpmVntcg=;
        fh=1vZmhPHifY405qJGURT1JAyByuefzUhkyXCUjZseaGY=;
        b=d+74ZSKFpnOiqWzrMz7uVg1o1s6eicd8pthGuE2fcF7c7g9JpaS4OP7vVFU6/EbXdd
         8v7Xq9NyhK2How3nasutwwsIuYAffhsg7F2u64ZB9wmP5Gj02Qh/i9gpYGdzzhweMdtB
         u1p0EzYKmsxFvOdBm6BvVx2xzwIc4WVMCEo4ZDVfKL611jc/P3Da1GOqbstxeR9VVcid
         jRRw7Qerq2osquXbXpKxQCsU6HKhlW4+8b/E9vVakaZeLITN7SjGDQXtvE//96T7Tljj
         Igwvy8RSWl/l7IQV4ZvaTbd267SjfyKQUbYDJEqxJMCe9A/PC/ATJ02h7X+L42vkRNmp
         wyiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792541783; x=1793146583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JUSir2q5BLuFZXQHqg/6Fwc618wXrCwtXkLVpmVntcg=;
        b=j1laCVTL3txBPYjWWVpjMIQ2W6tC6XgY1+TRm+wL33VlkQbBtqK8U7eyHWJBWr0ZTC
         PkqKCrkqaA/NjCIYOCiDEoru2HXRs6UQv6hZ/RazF3rEYzZuTyOpoHT1dyeizutAMBNf
         t/J4PRb+Tb03cJsc/ZIn2j7ZcYVn+g0v0QErf9Cb0V1ioCd54BwWkxiKI5cSu+fY56tp
         ZXtD8eqwlrmtIigiiFGvEwHk2mAp3USp44VwQisPJ/AGz4np8T1iyCUuuVmyvdvUmBog
         fS9JwiS7jsfQGtpenWyZOyzzGB7g2PnyQoi1qj1lrC2WRatcz2F3vbgY4iVvMMWPEpsE
         2/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792541783; x=1793146583;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JUSir2q5BLuFZXQHqg/6Fwc618wXrCwtXkLVpmVntcg=;
        b=aviYFrna0p888QZxk1D65TvDgn/lEmAzPgqZnslQQ6YmByZPWAjz63lgTHzotjYTj2
         tKrCVroG3b4rToWEQ4IH5n9t7dzUMkJEh0yVETsdDZCo79mbRM3y7IhHd+o25r9q0JCq
         rXSw01+/xc4O6lqpJwsTdsWdQQqWKY6OO4pG0dgStGNvNiTsE6GC455YMHWlenKcrrTm
         8TYkI7AgaN0+b+NVKReIWKVxeXdO9WvKmaQ6y08E4qKr1GxIoPYQo5GJi+GACgaCo4yw
         ZFJhQzmYUcEotE/MGSQSD667w7CKB3szHp7AvbodwdQZr23GDBAlb+vPh00Zy7FjQX3o
         eL/Q==
X-Gm-Message-State: AFq9FYJZ0VP38Fj1aQAkD3DCzrARQOdcnPEPYbYCx+u9li6T8d6vYKto
	e8U1G2qBlAC/tWe/GgHFg2e1mzP/5I4jwYmXywsexyOencTNT11Te/7V7n4dsBskWxzS8cav6a9
	NtkUrDPFRv1b2kqYeqvCDWiRfgDLg5i4=
X-Gm-Gg: AYBFou1n668XvDjUqBLI+4QEaaON+BvLr5cu5mLKAMGETyxJr9WPtSgx/u4toelB0eD
	cjVXPdUp7IPrDkyeFBJQouXrk9yE2t39FD6+ZtFkJy7he1kUf97tXdgwpOcaOkkbwge1kk2ziVy
	4q9B61ET0+TFASEgHLnTClYikOJIt0BiDMiy3CQ5sMOZuqrgXVg9lYYKb2LepwwxAnVUXH4WPyP
	274jnbbTxxWSX0nZAb310nwhtX17ex5UZWirBiI8QGfnYk5qX83A1pF/JwksMh/cB7XNgQfwSw7
	h5mcXtVOj0oqlbkSKnpM3jSxNFc08T/8hZE83oPkpnbdqhxtuBjVsrv6Vqb4CPCCy4/cLATODzr
	/2oE6fercFaiK3SbCl/jq1YZ6DmFzX6c2XErULdZKGPnnjFs8mQ4okuyj5uCLa5GydUU5AA==
X-Received: by 2002:a05:690c:660c:b0:8b1:ce5:be42 with SMTP id
 00721157ae682-8b133fe3435mr2771807b3.28.1792541783308; Tue, 20 Oct 2026
 17:16:23 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013181932.1739238-1-listout@listout.xyz>
In-Reply-To: <20261013181932.1739238-1-listout@listout.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Oct 2026 17:16:10 -0700
X-Gm-Features: AclHuK_gZWAJUCU0Ubmw8jXYAFhpzdlBus0Vb1Ad3mAeDSuigAmuyURzHqelNUE
Message-ID: <CAADnVQJ5s1MaFhFQ7Djz0a_ABumiEs9NKCCmGAbkeE8TfuZNZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/2] selftests/bpf: Add tests for memcg kfuncs
To: Brahmajit Das <listout@listout.xyz>
Cc: bpf <bpf@vger.kernel.org>, bdas@suse.de, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	JP Kobryn <jp.kobryn@linux.dev>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 11:19=E2=80=AFAM <listout@listout.xyz> wrote:
>
> From: Brahmajit Das <bdas@suse.de>
>
> bpf_get_root_mem_cgroup(), bpf_mem_cgroup_usage(),
> bpf_mem_cgroup_memory_events() and bpf_proactive_reclaim() have no
> selftest coverage. Patch 2 adds a memcg_kfuncs test for them, plus
> verifier tests for their acquire/release, NULL and program type rules.

I don't think we need to test them.

pw-bot: cr
