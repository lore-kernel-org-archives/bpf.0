Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9FF31F9A0
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291644; cv=none; b=apMJrNCw9KKEC1KDTOSBirEFjeqozWaQq+akVzJ4Z+SJHk3C7K8XsrNBeSYauL7E0gA5f3y0EVJuB9h+ISksvjZtiX61m5XBkLcyXMXem0XnE2+j0eQxS0mePiayPYJko6oyDHovFBFTbQHKT/FgNyLCtKruv/MbAFA7cDMyofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291644; c=relaxed/simple;
	bh=8Ew+jfhR0hDJihjz8CWrDl4vKMRYvlrELlOSBVASZl4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O7YWzkpUcn1SKmTvA8CjOywS/nAw9m80H/Do8jWF/hCU+kHt8WHoOoQ4oF3CjQkFxttphkt8Uz4t76gkO9SRG1wEgNhe2pJnv+g0NKq2t+EnCzHOqcFcd9ZCNKKTmUHmKGx+7YMUHOWQHNUCScZuG17pnRlAzYxXXElPVqfE9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbU01Hsm; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbU01Hsm"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-126ea4e9694so7977310c88.1
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774291643; x=1774896443; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f418HlRfYf2mGQ86ulK+tBu42r6h280QaayclMhC94A=;
        b=gbU01Hsm7mVyCgVnZjJWEEeaB7MWO9bytxcN5j9Vtr7kCiFHFqqSx1DfeWMfJxYdx7
         5vUYUba4n7eAMd1fM5uqKqEC6Ce0RWYpqzfJiBqQC4pH/2dPvVNVGR8Fcahql8Gql6Pf
         UaEcu96JEr8ISmYufYb/MW+MOLBVx1dhQsFeLUVkLHuxk2gCFn92hyta7lXw46sbmchJ
         B8KfqJyhq/uvp/GEOBNOdix9aYkIrP62+PlEqbSWRMqMF2B2qvul7j/Gu1yaaC83S6b3
         kY/TyXTSruIKzO9zkgAG1i28mwdTkWIUz9CuROxytzJVXaftPmJ0WCKgf1cJz3m9JZbS
         mGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291643; x=1774896443;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f418HlRfYf2mGQ86ulK+tBu42r6h280QaayclMhC94A=;
        b=Dyaza0gwe9O3NyD75a6cEm0YK/DKfdGqT9CLw+83VLAIMh/GZGt8WNxBiw4+UlR1kB
         QYBa+WWSi8WQUVlmQo8O5p7y9ujIVjGd4Xz9BtH6gQBmsJq1l5ghBesoX0pSWxU2le2B
         EiuKTBJsYqRcEDFFolplFabNHy/Y2j7T9FvSkDLXzKONaIAoCkVlhYsjNSS0MnSXrbD5
         36PPbOA0sc22VmOVFhLr6V9rqHSqxa/EXTksj+TW8F4Y7Entr1PO2O7kduf3W5M8EMOm
         jcg5EsRbRxBpcVNBQKH3n17xco2CoHL8Mh+yCHwU0btEaOJxrh2/TakkJfDSxA3TCxKo
         Vk4w==
X-Forwarded-Encrypted: i=1; AJvYcCXIwks5WhTF71p0eqMvu9l/e9WV7qMvbgi7nVmxI+OsB7FikXSShsnyTqzptRacjjsY1dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGJpWVUL2sikMlQZSQ8WYvGzSm1YdSAt3OIWrqekz/NR8Wsr+Y
	1GGiy4cgFE8dTHYlUKQGzzNngHlvPZV+GZWGCs+LYIk2WJ53dhE4V5V/W+2hhQQ3
X-Gm-Gg: ATEYQzyRVtQFJ+Yw/nmEXOkNIG9etRVbG0Ps/fMD7P3ZeRLCetWdH6f9IAv/Ac/HiOp
	GCrc+M2/TkgOgXGsa5WFGwFynex2+xN8XKWma2vdln8NxvXkHi/PHffHsR8TjUXcQciXiPYxhv5
	AuMiXkXjj/sQBdowyW3eUStDEngTKa61frcTdVmIo2qH4VQSRv7fWwtm0g6W7n3birSu3Gu5VRu
	Odo5ot+ubcyRIdOGhtpCbJpKCfOUHjXg6OeydktrP88kyO8cjJQkxLkoRSbwGTcORFu34Cdy9xq
	hVMcY24TiCQeHH1KQvofXiqFAGGa1dvkEUTcDU1Y4WLjoKoWHX7nE9p/9/Vz2vCIzKf2uXrmWR+
	JR6x+0bxMcG0lXFIgwQzFNYO+hoWdbTa62L2Mk/SulNSOLtpIf7+Naz2Rs3iflI75W0yV1UeVrG
	9Jdl5j1QqTFkdcZAuxsbA6nET1O0zy8LE47zty007RwOU2TLAqo5iXGGOyZcdYaXokql/Yn66yE
	HMzOGU=
X-Received: by 2002:a05:7022:4a9:b0:119:e56b:9592 with SMTP id a92af1059eb24-12a726b2fe0mr5675987c88.23.1774291642614;
        Mon, 23 Mar 2026 11:47:22 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:45ca:895c:22d:457a? ([2620:10d:c090:500::2:8b17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a73407854sm9786274c88.8.2026.03.23.11.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:47:22 -0700 (PDT)
Message-ID: <ed85ac25cd315ac4273de335943f9f3a2c1f36e8.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: Exit early if reg_bounds_sync gets
 invalid inputs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Harishankar
 Vishwanathan <harishankar.vishwanathan@gmail.com>, Shung-Hsi Yu	
 <shung-hsi.yu@suse.com>, Srinivas Narayana <srinivas.narayana@rutgers.edu>,
  Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Date: Mon, 23 Mar 2026 11:47:20 -0700
In-Reply-To: <704bf39f66a98877f66a4982c77cddb42f14fc82.1774025082.git.paul.chaignon@gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
	 <704bf39f66a98877f66a4982c77cddb42f14fc82.1774025082.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-20 at 17:49 +0100, Paul Chaignon wrote:

[...]

> @@ -2786,8 +2786,13 @@ static void __reg_bound_offset(struct bpf_reg_stat=
e *reg)
>  	reg->var_off =3D tnum_or(tnum_clear_subreg(var64_off), var32_off);
>  }
> =20
> +static bool range_bounds_violation(struct bpf_reg_state *reg);
> +
>  static void reg_bounds_sync(struct bpf_reg_state *reg)
>  {
> +	/* If the input reg_state is invalid, we can exit early */
> +	if (range_bounds_violation(reg))
> +		return;
>  	/* We might have learned new bounds from the var_off. */
>  	__update_reg_bounds(reg);
>  	/* We might have learned something about the sign bit. */

Is it possible for the invariants violation to manifest after
__update_reg{32,64}_bounds() calls, once cross domain boundaries are
propagated?
