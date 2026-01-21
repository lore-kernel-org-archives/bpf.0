Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D492D249A
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989248; cv=none; b=FR7vBZoJaMcBFcqoY58LZXJhKOfyaOsPl5/zjNJ1qyE1/h5JpdeIDmghdLauGSy+0XnkDJRClJ4KNaEOOmheJ7UJEt2f+SX/Ft8n6QARCnmONLhdMPWVxWQV3Jafz1uX0n5xxG9+4qw/6bhX40oVg6GThg3NQ+q1DIO/56NluTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989248; c=relaxed/simple;
	bh=NTgU+udkmo8b+bys+frUyrVCx9K0iFIwxoI71xMSPM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTrtOAvVprVXi8UO/JvZ9aj2Ak4fQQKKDla713p1ZE5fibtSqQ3ZJUfwVUZ9jcKTK2o5o3rP560fg6VHrXLz1h5MfOaXT6y+Zc5LogTTNYUDFlXy791K+4ulWdqTG+LqgA1Xpit4CBt2n8DSLSiKaGwUYKLoayNOWrUC8K+wlRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RXGCbdmr; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RXGCbdmr"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b874c00a39fso123934866b.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768989245; x=1769594045; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ekpQy0hYQiLZMiu4CpOE6p7zPKqu8L39urLy2shV4+I=;
        b=RXGCbdmr9/D/mJ5FbZbFN24EUGUyaWqh+RAny1ML6NCgVzhFJ/jUDYtLBB1/ooCaUx
         S2m1bc32x/jvY0b+xrlUu7vLT1w4VdCIEx45HGTMY3v0r6fWSI2ZzQ/g7eBsxvP9bbgP
         GGIBB1SGQqkzmYT0uDXYNt+paT3r8pSNPNsHoSwopTJ9W5HGQNh/SdcJMrLnxsumYcgS
         qLatRrYcYdB+7+XSxCqKJgwC03yWyI7179L/K5Vqiw+vJGBSuFV3qOnlrJRXwDUPpe7T
         cRAXuCOEwOr+zVDqLRDNdvq9DPqgkiCSy7mcm70GaljmPD1gENeUlb7uvstoPveEz58/
         LPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768989245; x=1769594045;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekpQy0hYQiLZMiu4CpOE6p7zPKqu8L39urLy2shV4+I=;
        b=n7D4n+EEtxbwNIPOsW4pQIXRZzxBci3G74ynWqCKPhGBlsS+aATVgQ9VNlH5+u/4XV
         5nbaZ6HK+l6EELCqW032sdR/V6N2P2bjr3qO2jSH3q3L6MsW3dRMPLcpMdCHyECutT2w
         Uct9eq1ItIxr2b6/j/9r27RmjVclhE4eALJ/pLmdRT1dJ5iMJamptNJn8cEblkHnjeqa
         rILc0rnR1GcxgBvy6MBjj/gv9DuVBsauCHYvY49NiLT4UFiWXsbiJyVs8zrsNIuKuA+7
         sB9y89qMhT7OGHAC0xqtdbxAxZagSKtPYagq6ZWWuYp8mKynyChWnIIkP3+rZMiuCclH
         vZVw==
X-Gm-Message-State: AOJu0YzR6GWfToFmvyZ9mXoxHzNTWz47q4vyugMBItctNl4svlpwZT6/
	HKY8pOy2AjooDhN1kv878VZ9jH0XfxiLxvUWq85eq2epHZHOGUVefO3FNR5q86AtYxc=
X-Gm-Gg: AZuq6aIuf/t6hzc66Y2Y5boE7RmKHjkFvsny7REPgV5uyCW/X92PBPZULzuRrljoSgO
	GrXslmDvocKRWO2/3LqYDvpsm8BisC9wpIZo8n4DyApHk1Asn2MTTO2VlT0/BOTT/v/L4f9H7u6
	DRq0kzYh8ZAqItB/DwchlRwi5HhNTAc9+2JyJd9BJ/wLicoTkIZkj37KdXVvHhttuEOlDwm/hci
	B/bOm05G5CCvs4RIpsv2xkumlJVPXkMTpttHM3zn3rnxbUT3W4+/KO9PfF0dElRhQwUQs+zZsMs
	F1un1B5hvPAWzgDaSnEldi9L9vNQ049krI+jm+i73bdRv84EM2PBpmdcnGAMdELsiEWpsZVLTdD
	PuCYJgZbAn919a/RA2Ug7Kvq9e3IEMJvD6HcWe+zUME4Ut9B5TttvEkK0jy90OmkBmL4sNpca/5
	9Org==
X-Received: by 2002:a17:907:948d:b0:b3a:8070:e269 with SMTP id a640c23a62f3a-b879389056fmr1832883466b.14.1768989245421;
        Wed, 21 Jan 2026 01:54:05 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a31fafsm1474473066b.66.2026.01.21.01.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:54:05 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  John Fastabend
 <john.fastabend@gmail.com>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong
 Song <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Amery Hung <ameryhung@gmail.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 3/4] bpf: Remove kfunc support in prologue and
 epilogue
In-Reply-To: <8eb725d8d0878a7a1b582fdfacf05d20a2542304.camel@gmail.com>
	(Eduard Zingerman's message of "Mon, 19 Jan 2026 14:55:29 -0800")
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
	<20260119-skb-meta-bpf-emit-call-from-prologue-v1-3-e8b88d6430d8@cloudflare.com>
	<8eb725d8d0878a7a1b582fdfacf05d20a2542304.camel@gmail.com>
Date: Wed, 21 Jan 2026 10:54:04 +0100
Message-ID: <87h5sfthoj.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 19, 2026 at 02:55 PM -08, Eduard Zingerman wrote:
> I think that patches #3 and #4 have to be swapped, otherwise there is
> a selftest failure when only patches #1-3 are applied:
>
>   #281/17  pro_epilogue/syscall_pro_epilogue:FAIL
>
> If we want to keep selftests passing for arbitrary bisects.

I don't have an opinion. I assumed it'd get applied as a batch without
fast forward, so bisect would be going over merge commits.
