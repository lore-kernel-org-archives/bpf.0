Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794426245;
	b=Pq9c7ls2Xuy2hzhiIlwf4I7ebQAVS0HD+Gn8o52ady3inDeadGHSsGoCKnITYPqmpUpZ
	 sbbPkiR/IQZHeF9IeIO/BVlg9TwpIzExuGq35ZvzIQwVIPXY1huAK11Vq4U2j8XQg1L1o
	 Fogq9tYj4H52HIrW+qA9UKkBoYxu3EOHj/Mm8La0RrsHfZAp+NT/i7BH7GJleZAPn7sEQ
	 oStQhfdBil7nWeK24qEWvVuYW5VmR6TQSUPzfVUkGBNeRvKnvOjFqIIUsCwcmYJ2OAP66
	 /ID2dYSV6PiwsOoBx35xJYdI11zT6kezJ52RPvMtUolsLaQd1L2NLysP31/k3FJNGGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=0c78mVQK74LynOaPiL/mQdianq/QQ399Mugm9IGaPmE=;
	b=2WfbJOiVgdGj9Et6U8ZmrOeY7bCX/jH08I9Vi/33Rua3fq+sNkgMq/BAtKfR1kbm5RIH
	 KTtANm5lNb8hgXxjVLXJxTbH4Ob/Ussr6uXCF64QJEhxftaAAx4eN+/9eTpQQflHuCD8c
	 5GMbwnjNV+gKnF5vXWegy9SsvXYyZ5UOnOSrRCGdR84wWt1CkYGhPP6atA0GAKmo8TrPk
	 Pl5a93VInyjiseh1Vu6zpCgntYOV58WumgE63Jfuwhow05VGmORzVUbiq05jbmh9hwViR
	 sXEdg1hSkhE0vcQ8ugp/EWNvzBMAJCCrc1VZeRoxMHz14cqi69W83uiSrh2gQYEG1FQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=Szh2okIx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26551606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 19:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26551606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=Szh2okIx
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b147e50af1so29209a91.2
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 11:44:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794426244; cv=none;
        d=google.com; s=arc-20260327;
        b=FG3JmCi6OqPRLNyeiMBY0FV6a8qMeptb7pP1tBEJ/cbZkMZ5R195UVEVuk8hEkG+W3
         OPm9+kELWArVENTR4szbEjyUWxna1Y/is7XusLZtGALdcJXqkc8hyBomsni3rJ/dnyMI
         fqpgbeEnPfrcfjdY7Me+qBHoQ17ftHGdZxsx6cE5Mg5GFQ/0qFqPUGuZ2RnvHDGxPya9
         3/7/p7UW5xcuO/jyuHhqoXezmL1zPLPA2P9d9TEjt+UcOM9sVuP+9tQOXhVtXSkIWSwn
         Jw830BUS+jiCEX7HA0JjcDJamP4C09SBcTtIBMtelHUm58cj8BXl2sWWMIRsI/CrU7KY
         cjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0c78mVQK74LynOaPiL/mQdianq/QQ399Mugm9IGaPmE=;
        fh=ZsWqngyag4i9v0vz6MF0y4C4TfuAEUsVbAbkOloOb+o=;
        b=qfnTjfPyHi87nkZ2wNCSeDEYhxyhe/ZpxlGO3CgBhOGNaetMcGO+E6IAVcJ88AxGBr
         i5zTnxAlZk6zamaa73cA+CRGMg5jhmdB7ziCbuDvrKEQTt7rYo5vQZooG/H0j/V57lmF
         4O2WN7EKhE7iH8dQStce15n9olJGIe0JoPUrhtsfhjxGLUxkP12nFgUbeN4iaj8DJdjQ
         hG/U9VYnhIhnfY0NoJuAYuBBJEH57SLcbWGKBbHjf1VZtTk/tnHELKWrbuHYYVAV14vZ
         PEhVtTzNBIl79xrG8C6SDTAH8ycDJRmAlAPkHIKIs0oD0zuUvJksdc5HUqmIHS2dsdRv
         O+pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1794426244; x=1795031044; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0c78mVQK74LynOaPiL/mQdianq/QQ399Mugm9IGaPmE=;
        b=Szh2okIxPn42DAW4rJdqCEHxXRlzlWdQUlKv14FIT8XWsBz5vjlzjCzgn0FaVZJDaq
         39Vm/RZA8ElBOh5u7Mzw/+Py5wvddWw8SdG8KrjG/yyy8Ut6dOT2nB7Vyod/G7kRfDo3
         NEPXrzu6FpqalSZZElj1FedVp1EH7SsGuZAuWq/Fc+rmSEGHijFtFUjVehCGYQrVNDMH
         KupkNOerYb4ew7Ip/cWcDzIG7fjaaPi3kqNlFlLTFMK4PJIiWmJFryJmJWgX6dVYAq0t
         Beud0aSkg1ydIKiT7aLPx46cS4KidcnGADP8iFP6WwLwMu64NJpW1IQiHuhhjYL0ooA7
         u78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426244; x=1795031044;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0c78mVQK74LynOaPiL/mQdianq/QQ399Mugm9IGaPmE=;
        b=eTGUR4EIxUkfzurBaQEZi1SI+q/C/d83aw36Jio8ca6BgE2shDKSMC6YZTIFb19Sos
         JRJW9KiFjP4O4yj27DLinICVRPzev9wUy5lGPAOUf42dEt0SPMSF11De5UCldrW0jZUL
         Bf6tGrlBGgvUgg1jsG98ztAfRwycV9QTKx6AWGuo+CuwSBpBMiCDq9M1dD5+nVsoupao
         D3DdqetPcWMWCTk1yrmKW8XGI3RCz99gD9uImNaCz8Jhcg5ASJWCAMRa41/hzV4HhbvQ
         Mp+W+zmYiIpHf1DDeSdApazQ2dyx+jA4rj10DFgqHZ4R9mfleClDFCvD2IR+JBbA+eVt
         1CLQ==
X-Forwarded-Encrypted: i=1; AL+hErGEvaYOOPnNTPQgd2KpZm/a2RFSPBmLoCuZNT4RGpu+7LcyeHsOMcIXmfFO91e98V0Q+lg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DXFLLGQUQjGbxc38frGvW2SmR6UIbyz+v4KmrXuLMOyV2CKbx
	7flTYzjmJicVRMq1hb6EIqVlEGLJvJC+H5WATilALJJYgyxns7nVYkbDax5HP1+7+aZ/QWEonZN
	7BrkA0G0AK0Rt7lIEdZhHW/ys9krERRS3STm2DQU+dg==
X-Gm-Gg: AYBFou0ZfLDbL3xPmfrU2CsXpkBLNm4ZPG4v+QTc0cyqDzOsaOUS4IWNSORJYR74Zes
	6iDU3w1bnvxqJ/LCPFHtfnELZ5V5+SOZVuRcmtdXPWo2Jxaq0JIweJ6f3xR1KtfhY6SjxXXgTKI
	41CfOvlSw+/UAoE/H76O3+3wrcJ55TeiwDezudcXp4nnogViJJVfRdvnUFyLvGirRkvsVWhx5gF
	N/NgH35crW6KAwZBC2VIktV7StLO6kd69f/BPaixAyG9zjXXX8sIJ3HIchiea0/5rSCq3BLiLws
	wrVKLxs0UbXThLa+Ev3FEvWvTR+z7kGGT6U/fOhWhiZ7eqvjDXmQ0EBL/BOE7VO7BIxydWxc7SQ
	eM+O3qLM9iwj3mtTz+z83oU/NXOErp1ICN8Vd+ehW4dA1z5fd/kH5oYQ=
X-Received: by 2002:a17:90b:3d82:b0:3a8:9db2:a59 with SMTP id
 98e67ed59e1d1-3b182d37a0cmr4916155a91.0.1794426244317; Wed, 11 Nov 2026
 11:44:04 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025-b4-bpf-trampoline-preempt-v1-0-fb8eadbfebab@sentinelone.com>
In-Reply-To: <20261025-b4-bpf-trampoline-preempt-v1-0-fb8eadbfebab@sentinelone.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Wed, 11 Nov 2026 21:44:07 +0200
X-Gm-Features: AclHuK8saDkuU9yD83aEJP9vw27K78S0OdlGm4k94CqvQAsOXBX2ygr_2svCp3E
Message-ID: <CAPnbwjrf-X-p8JSkF2xcxz9weP9XxaLCiRqQLuCd=09pNQxtSQ@mail.gmail.com>
Subject: Re: [EXT.MSG] [PATCH RFC bpf-next 0/2] bpf: Do not let preemption
 cause false recursion drops in trampoline progs
To: mikeba@sentinelone.com
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	JP Kobryn <jp.kobryn@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi all,

v2 is out, following the discussion here. Instead of keeping the
programs non-preemptible, it checks recursion per task through the
bpf_ctx chain, and it now also covers raw_tp/tp_btf, sleepable programs,
BPF_PROG_TEST_RUN and syscall tracepoints:

https://lore.kernel.org/bpf/20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com/

Thanks,
Mike
