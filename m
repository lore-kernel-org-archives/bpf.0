Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4F1E8826
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790943894; cv=none; b=ovVYkSEtao8Ob4pb6sPMIaIAJSYetmoG57udSfj9sjc925fQS9nLQaK6AOCXZlzyuhDyBghTe56PZEVidQqsoy7q6eb9aCemMAqksPYzbjzmKJyl+NujziCDx7mNfxzERkEBbnYHig9UPFzTg1cRZHldRGKTuKKTHnlQ58Ay888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790943894; c=relaxed/simple;
	bh=6AsqsAjWl9B5NrRGRMbaRcJ/dOCDH9gpvfdkGsXfJdk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=ZYPGKCY8NlMNM29BLnaPFyGgExgY6Z+O5B3AtTXhOy8lwXtDZjCe92LV6Ud1HvdecO8HoaU/h9IUms62ZTUJFykAi1MH2GwNapp/lhrygizwsiFE3zOrgIcLwAHd1HYwau8yLqmy5GyB0tmX2pTNCKdqAHJ2WdXe29VUNh+DWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbRx/96T; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbRx/96T"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb751so3676867a91.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790943893; x=1791548693; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6AsqsAjWl9B5NrRGRMbaRcJ/dOCDH9gpvfdkGsXfJdk=;
        b=gbRx/96TJmAKPYT3Tjymq8yVSZMxiHCZ3BemFqBmN5brJSabjWDu2SgK70phVhpOFm
         lsqf6ike6MjbS55kvRTavlVCfMNBp5FxoJl+foWuTUfIsHcSmcS8PYcuZvO/QryxKrS8
         47SEXt9f6SgxOpCV8WB0v8H7lcY94t1sdmRlU/go16ZIE9XcIOCxqvFL+kl5VetxlGVH
         prFGqF8yiXPXSFR/KxAx+yvEBtL4fzWsUi4kkvzXxtrGgQjLHxWgunKLykT3Di9/dJZj
         qHdQ+WGKUQ1k+SZVZdp2reKAJtOg67dcN2dwHVMpeDlsamMmRBJ0te6tQXpyiO2cQvmw
         G+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790943893; x=1791548693;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6AsqsAjWl9B5NrRGRMbaRcJ/dOCDH9gpvfdkGsXfJdk=;
        b=vG7OrYchUR+UTNjHCEmGxTqecg0AXMHr7QErE5dbub1L9IjmioR8M9ytBFSMkejpCH
         bVxf0eL9f0CjO5WFlcjX3cVoFznas6RQuNqquHWeXTYgv1mpcKDLDnol9SbXC+mTBPwC
         kJjamb+rrIS7auE6AJMutw35lnduHk5E+osLZx6KZ4TiPIqJCAyCxHBPJp6km+UPu+Uw
         O9iH25BWnmGyUofyD1xT8Rt/tjBcppeKGtia8Zki5CRHblNYmyHa2OYd4a9kf3GeBKib
         7tHmX5m5i5HaOSR5gFM2vIeCKjLDGI63/AyLIXiJEBmKsKWe3kTcWg/rShGQvGe4z+p6
         yDhQ==
X-Forwarded-Encrypted: i=1; AKwUvBynmHJCRzugNGoWwCY2Wa3bDsOoyx74e3B5bYByhonFnee+5Zypa/FTOn1IM5aOOxWX33c=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5rOk8T8C2s1Px4FXHfJGem29cRL1+SmxfWee3NGuFhSLzFHP8
	Xj9J704F+QBaNJsMQgIxvZS5iZAA7GAOl9jVyHqNVQikNjvdCU6u/A71
X-Gm-Gg: AYBFou12JaKRvD9uwimnurizgrsoBg0nuzAHm6oscGF02IcBb6vHTUnHMsV948iHHcs
	BcyHFOFItCbdVIK46Iv0VsVyLDYeN1ZdKqLM34wmi3G7LkWOdyMkNaW4kkvvZRwGO3xp9PGekzo
	CT9Zd6YvrGBoR07W/N0kJtP2ECb6g3k0+9CzvM6UKOvzOwqwseCoZ572MEBU5SjlGKGmup4Zf02
	ko4D1vRcAIF69rZo/N1EHwg+V5skW8R1vob9QYrOzKHMbQSCTtgpKRj7l9jqmhTJOUq+t8ZWu6u
	KFp8xDV3GEPK25VVQQnd7rWe10ovwDIWg8vCWG0SHNHRRsEXnvpL42vD5h3VFPuyTiMyBc0fe7a
	Hz+no1nLW6zRcXyHGqvCfTZuTqXhO4kh/eoDl6JdbegwwrPKn+F1UDl7giZArn8hhGI8SSbStCA
	XinYlAmK14a0poxh4BOICtu7wAfLbGoLU4KKHJiChn77GHzSj3N8Mm5WY1vtxmrvxt2VbYmeL+z
	s8wX9z2LYyh9mzAv8JayTgbwgRqpjaCUVqmNZIrSdCBKrnRNpH0qF4Mp+FKcUqaCpv2TbEiEBEP
	YxY=
X-Received: by 2002:a17:90b:584e:b0:39e:6c69:7777 with SMTP id 98e67ed59e1d1-3a6cec2c08emr1419541a91.32.1790943892714;
        Fri, 02 Oct 2026 05:24:52 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f402dfbbsm8896303a91.0.2026.10.02.05.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 05:24:52 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 12:24:51 +0000
Message-Id: <DLUCMHNWQ956.7GB7BFNWNPYU@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
Subject: Re: [PATCH bpf-next 05/14] bpf: Allow names of Rust types and
 functions in BTF
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <bpf@vger.kernel.org>
In-Reply-To: <82f7ccc5-da2a-4b78-a10a-442acfac1855@oracle.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com> <20260930193127.2181684-6-alexei.starovoitov@gmail.com> <82f7ccc5-da2a-4b78-a10a-442acfac1855@oracle.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 01, 2026 at 06:42 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> The idea is that for tracing rust functions you could specify the rust name
> (from DWARF DW_AT_name) in the SEC(), but to map to the actual symbol
> address in kallsyms the decl tag that referenced that function could use
> the DW_AT_linkage name.
>
> So the decl tag would have the form
>
> <lang>:linkage:<linkage-symbol>
>
> and it would reference the FUNC type id.
>
> Could we do similar here for the name -> symbol mapping?

I don't think I got the idea.
To help with mangle/demangle?
bpf_prog_<tag>_write_fmt_scx_cosmos__BpfStream_
is imo readable enough for humans.
