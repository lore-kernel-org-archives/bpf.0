Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC1582B86
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203184; cv=none; b=tlUemJ/Ni4dK7DaE2IH7v4E7KSwa0SCZftbuNVdIu15oI9MRgvmncCWC7/KbqnY8/YfWhAcydIAAEgf0qlpV8CeaYYInUOlpUYFocBSa+gKpvNth8pcooEh8N0Uyj18rtGEAJlKZw/p2ZCHzR8znAOhnVoOWKXoejctqlhV8hnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203184; c=relaxed/simple;
	bh=wbxPComiYwdmQJMhjBrepA9KbST17o6Wvyt994EkVWk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=udwHlML3SqBlArS/tXW0JF5JNt9Ikmz7dlrsxXMakqOci8A7PaYVd0vLA3gPvB9Ep6PVc9OkycncYnFCWXL9bjbU04b+k/ee5gNQ6Ovw4fQBpHNNXXxKp8HPyinoGseHhNnCEQ9AInpzLzF5XeUiojxOW7aldTpUlef3QxZZVoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeDOUBuz; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeDOUBuz"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f089b1e3so1286810c88.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790203182; x=1790807982; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wbxPComiYwdmQJMhjBrepA9KbST17o6Wvyt994EkVWk=;
        b=WeDOUBuznjUEW8WAOA1ANm072DjLv63tfd3nnJZio4z53dwr1KYwLVQgcN122BA+Gj
         HoVrwtZwKj5UvnsDQTWKaxjJftT8R/6nkwI7jymWfmknbIXw4JSVfPlpLDkgXdPJPJf4
         icOMzmZO8dOTRt0iyfRNxEzwnU55Gx3Xid2xZCBL105IbE5JaftBZYE/G1ETBl1ldQi4
         OYTAZQlg+cl1yTixk/gzswA0pSsA43JcAdq1wgAO6f4CWSEem4pbAlnVjuob37h3zQ5e
         oksmL0Y5B4IyChrRsoP9QD8bnATM7fTWfkXs4brGBmBPdu6ATZvSa2lklXbLIBGRttc6
         v7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790203182; x=1790807982;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wbxPComiYwdmQJMhjBrepA9KbST17o6Wvyt994EkVWk=;
        b=wTvWUkQbn0ID6/iaErvNFcsdoMMLfrfcw27UERJdLZO4m3CZlBufcDRIaq7k/78Jbq
         Ml2J1WIWZSMjQe9MMlu1BGPbZU0GOT+x3JpdhL5zAPspjAYY5Odz9AZOgHbQiI3/dvcH
         s8BERrebPARtPcvYWYJqbWH+pRJmbTXlXoe068Kl2Ll2nKjYO9Z4spbkkDG7phuLi7tR
         JYowtkMIhgWMZvnwyTpqfngmcYpODbTNJ9TixlONev4RhHjUWDsHZtlKv0N8tfB1A2T0
         zPztx0MkbUjvjEuZKP0IlqrDmUxgvQ2EqDvNRe0VeHqeD8tyLBpt0ZzqxtuFmWOMEh4R
         01QQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIQQ5fKsrUcuCZBhg/14064Z3ys6KVHIpritHhK5iu+bxqjsHzBOn+U6MNmhbfuWyL/sA=@vger.kernel.org
X-Gm-Message-State: AFuF++lTMY98wZ2ZyZg0Ut8CgBabdwtRRVSgAnZcfgL8xM/FoxJJ3n+h
	v8uh9wxfEt3MBnGaaJ6xrbs55xzQ5H9MApfbJx9kh+puoaucAYm2IsYy
X-Gm-Gg: AYBFou2F6fDsFCZtj9ZIN1WKg3mRvkZvtCEnYNh/S+KKurW4qqSVN42884SiHryQYsB
	w4Z1olj4MjHrSziN0fortcViBySUoauokPJXgsHq2qyzzlZn0yASESHStewMZFA/B76FK75DrYB
	CHjOf5WypEHm6jJn9T0DW/yqgKB2P5JeVGQkHDaRTH4etfgRK1KiI6YELuqbZUTg4QjcJuPoKMc
	Tc5KAS4F4GwDEU0cxgnefsSMpK2rc10qlByiSXjVVsmG+gL4yN7Flbp+8D5zydiuvMRELqycMjk
	8ampYwBkERnDL6tAhOL1kowbdiJYq0BDD2Vl+BCajTyA3ONjCbLU07rRFo/NInE/2zuYDdCdh6q
	+ddRcRN2ilIeQV4eFcF4UMgk6lRH/068BvvFUX2qGmmqMyYvwuA9kGtrtQWYfTWUjafILkZy8hk
	fbbbkoxvvnYHkHdomkqHkxqymlvsle4o/joLTe/+FRsZBqHsqSaKtWSxwkgdkqqEUMfE5OcsTOA
	Wom+0wW/nS5eutK9POa7QjIJfNCDahJrSPQsuRcEbZ2qGziap9d+8ZQAVriPfCHTHvf
X-Received: by 2002:a05:7022:1e03:b0:144:f85a:a188 with SMTP id a92af1059eb24-14503f2d6ecmr658539c88.2.1790203182286;
        Wed, 23 Sep 2026 15:39:42 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:179a:a128:9d0d:40be? ([2620:10d:c090:500::5:48f8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f983d73fsm10881904c88.6.2026.09.23.15.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:39:41 -0700 (PDT)
Message-ID: <c53e2a2ae43adef1e9ba3eb4dccfc032d9ce2f11.camel@gmail.com>
Subject: Re: [PATCH bpf-next 03/17] bpf: Don't fold loads from insn_array
 maps into constants
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, 
	a.s.protopopov@gmail.com
Date: Wed, 23 Sep 2026 15:39:40 -0700
In-Reply-To: <20260922011323.1298619-4-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
	 <20260922011323.1298619-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 01:13 +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> bpf_compute_const_regs() constant-folds loads from frozen read-only maps
> via bpf_map_direct_read(). insn_array maps are frozen and read-only too,
> but their values are addresses of jitted insns that are not known during
> verification. bpf_map_direct_read() returns zero, the register loaded
> from the first two elements of a jump table becomes const 0 and
> bpf_prune_dead_branches() may rewrite a conditional jump on it.
>=20
> check_map_mem_read() in the main pass marks such register as PTR_TO_INSN.
> Treat it as unknown in const_fold as well.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

This one does deserve fixes tag, though.

...
