Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440FB33B6FA
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969981; cv=none; b=HKgs9SGHKyigS95pZC9Mwl0/9tAsnQy65imbSuxVKIKd78C73aFB+ZH07gcq2KLh6a6K1VRzfayElhAdrzbFmcSMH4bW9WOnZMd1OBICmV9eYNtms8d/YDB0RfaQZ19x9h7XcNa51ztvXqvm+3ZV9GciodNd3u+k9f9AirDoicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969981; c=relaxed/simple;
	bh=T2f0HMm69vMDA8ktksHCS2CrP9e+J6UmHCWjybnH4As=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rl6Il+v9JbkzjbPKeC9VcLdhVleXJtT2H6ETj5TdTne+sbKeatF74+fjnXmi1F7W6q6Ej90zoDKBA522NAi00hB3VTEuAbeIECGsuZhwWx/8UERhXvyiQ4PnqQ8ozocAf+/tTpzwVqS/NOdzDmfp0U+Qrhd4YRC8baNPuXzTapI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsSoOxxT; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsSoOxxT"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2baab3137bcso5165125eec.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 13:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771969979; x=1772574779; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T2f0HMm69vMDA8ktksHCS2CrP9e+J6UmHCWjybnH4As=;
        b=MsSoOxxTbLfUGr6paSUB39jiUR6tzEZsBhEnOf8jWsDE63pjpQ0bCPjYFg7C1hEgNj
         xuFKrcLAiVz4LsejX0uHdyr9hwli20JPHykyYwkm1l39wzdXqKC619sXYQDIrmtRy2c3
         W20AorNxSsIuB5EQ+rhGdae7w+hCLYmuVH9pYhBElph1I+bBWZRuJAu4a7xLWPB8ZVaP
         Gj6GYiuwDiX+4cnzEThhkykhnMHLYjF6EQ3EiwA077zHAQFAXjSua5PHf6nweERasmid
         HlW0prt/o+l48Fnve5rsvs7jn7mBQz4ZkVM3IuNAPcjhtD/08xJS+ZE7QAWi1RkrywCh
         fDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771969979; x=1772574779;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2f0HMm69vMDA8ktksHCS2CrP9e+J6UmHCWjybnH4As=;
        b=NpZr208ZiNxwFfI5MJS7H+GPStNjBh4pNciYli50eOJSOkpjEcOM0759JKDtM1OYvD
         znAwSYRF49t9fVbqy6iSsc5A2LDPcLT7H0Acmfj5IT2jJGfceoaCPNLpJSHhn6pEzfWp
         w5Val9haiyMeok/mCkqRGksFdyy/OY8H1XnZzZSPJ1pd6KPGehn/pLyyJQSiLpc5WAXO
         7DHhZ7IVKitZutctRZUv/9bgd1/kkBBEic2//jDCe83Tv28FiQPOlfISvZBH5UncSdFq
         /D1PC/Io2BTcpyy2F+GjJNcxMzhHFCCk/ZKt087YJ283tWrSJ5TTbDgAwbhYM+X7TYxF
         o35g==
X-Gm-Message-State: AOJu0YzJZKQEqlXaMiDIiUv8UG8h0aCcl3u+NrFXYp18ZXDoxN7EEaIY
	O331GnAETdmfsSy6tgff7Sq8OHc6FXSzymRTMuvzdudf6qT4ZXpr6hvN
X-Gm-Gg: ATEYQzxTLsfXhxaADBehcVCd46ypBy26DmpyXuthVdza/WKPnlpAhCcg1ZY61LH1gRQ
	zJP93RZzRwyb0TDq0zbnQFYYga/BuO3hdFim6V242Zee+BOCl2Bt0Rw9lLSo/rg7N7r+4JYILsN
	Snz2ZUCw+4lqMGS8di5+T58l9semTkmLnYwmnQvzcfIWnsdgciFBVEdmXmsl1Qzxf8zKFp+V1UT
	bJAxKLZ7coa7U/dT7yvWhNhcEwOrsxzx3pkXJr/IhLa5cL74r1EMJ2U7rczpQPlBO/IWHDlOtJu
	DmQobiQpfMWwercvzGfWbcEt/vukUhGtT1nJnK02m2EyoWLD8X8TL74BfIxB1hNHP8hZJ6jeUQO
	uLFwHdZB3Qw4snAwdWR/5ZM/oGJg8KyQFAT8egvwoZtW5t4RaJLV+QdTCQrfXb7L0pK4H/u70cr
	lxUEj/gPz4soyFG2lsj2LaESycRxlsiHJVXt8iHPuWzEfgMRSaOjBY8cQ0CMtJgEXDXJGxqzhTg
	wlb
X-Received: by 2002:a05:693c:630c:b0:2bd:b824:f462 with SMTP id 5a478bee46e88-2bdb82500f0mr860800eec.39.1771969979194;
        Tue, 24 Feb 2026 13:52:59 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:d945:dbc6:b702:5c73? ([2620:10d:c090:500::d49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe8198sm7560714eec.22.2026.02.24.13.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 13:52:58 -0800 (PST)
Message-ID: <179f2b813fd096a3975dd4a66b5da063fb593a64.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 0/7] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Puranjay Mohan
	 <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko	
 <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Date: Tue, 24 Feb 2026 13:52:57 -0800
In-Reply-To: <CAADnVQKO01A+PjwYCu9+HB8PK0Kb4+HGM0ZseUzY3eDMvSPqDw@mail.gmail.com>
References: <20260224212535.1165151-1-puranjay@kernel.org>
	 <CAADnVQKO01A+PjwYCu9+HB8PK0Kb4+HGM0ZseUzY3eDMvSPqDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-24 at 13:46 -0800, Alexei Starovoitov wrote:
> On Tue, Feb 24, 2026 at 1:25=E2=80=AFPM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >=20
> >=20
> > This series adds KF_FORBID_SLEEP, a new kfunc flag that can be combined
> > with KF_ACQUIRE. When a kfunc annotated with KF_ACQUIRE | KF_FORBID_SLE=
EP
>=20
> I don't want to introduce this new flag now only to be
> replaced with KF_ACQUIRE_LOCK.
>=20
> the follow up we discussed in the other email is different.
>=20
> pw-bot: cr

Then the refactoring should be bundled together with this series,
otherwise it is very confusing to have a flag named KF_ACQUIRE_LOCK
and bpf_verifier_state->forbid_sleep_count, bpf_reference_state->forbid_sle=
ep.
