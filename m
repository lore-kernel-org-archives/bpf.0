Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9F03815E4
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798919; cv=pass; b=MeaOxDuI9RaCI32qDKq8oM2DWjWNfRd6ut/JKueVul3pjHr/o6dyyNyWYA51neYYi2kzqMByPxr7Z90UeaXxX1pgUxaXRQDAOKTzbepUfvMeRsIUpYX2oBd5iiO1kgiSxmOUKIZ5S7LZGZ+eG5ZI4Xq30LuO8QZX2DA3woCSdUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798919; c=relaxed/simple;
	bh=wYglXmwgP+JSmWsymKCvK4vue0PoG+iaiidSWX3dgOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHXkRqbk9rplFp5eugsT8roHMogVCztE+0Z20rB5KLdz0+E2kC81KAMGsDGroCU+f6y3HRQCN8qykHCZA2yEZZEFc4tozXF4edV6TsiFnor47sqgctnAyoSUn6wf1BqT57eU5rgRc+FdD5ahzB1zRZA9gMoo4fJEX8/jjboCQ2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anVNJqNa; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anVNJqNa"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7927261a3acso83294907b3.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 04:08:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772798918; cv=none;
        d=google.com; s=arc-20240605;
        b=knIt9ILDsYXWFTRwjK6j1j+jLd+xe6deXKn40n5Ij57Fwl7BRHWFt0KAeUNMhZ3Cd7
         d8+uewNDO5F4MUl7Be4x/+nrpgz3HXw6PiCOIXqtagIREUehC/taz673aq32Ck4t/yy1
         mNzgsEn2VT2pTryGndc/H5by/PR4gvKVrpgmOX2/U6S1ZumS0ra4gEpUAIsbYxvReJHx
         q3ip/8f9cV7zGkqBsCSvUDuoVVe8DpGA6+cRBCpW3PW6tDFLyZmyFC1m8Qx3cNfNbJst
         afM+ctAT/6uhb6iv77MCxfgXUvEzGCeO7yJ+TVauKfMPDmwkfKds+htBmRYeuLzbx3Sf
         GXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wYglXmwgP+JSmWsymKCvK4vue0PoG+iaiidSWX3dgOE=;
        fh=tRIThAds573jTDIPiU2xVL5FEarkGRhFWITIraJOjFQ=;
        b=b48QDJDH/O5ZhOIs0khR5Ak+B15FJT3B2lWSHuTpWiav2Gswd3cn1y4uHLQmSKGQqQ
         OIzX7vgHBs0L3fbdOi97B0L+HR4kOcmb6NbGNjG8W86KOe3KXGrhU0uzV9AO97cprN7c
         flh4MU08wfpm8d1Vf5V3ExOY02PXQ0nrknK771jDL66/Tl2+Io0dgscdleiIHHZ++8Ki
         uwMeX5W6vp2Kefs5ekFwhVaPofzhzih3W3q2iJSh7HR/gs3FRnBg6GtX8x53oZzD4C4m
         zd6SQEs/2E0RmaRPOewETICnHBIJ/QcR98lerduNeu/RPERZamlARwZeWYkCnxpU/rdV
         T/kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772798918; x=1773403718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wYglXmwgP+JSmWsymKCvK4vue0PoG+iaiidSWX3dgOE=;
        b=anVNJqNajBIow9bnVcKquOuiw3ZRjV0TbzHVuQHXbd8WB57LsNa58JwOnKPdYZ5Qai
         1iQAlD8cOWD8jytb3F+s5whibJr/7NCddwIBBP6T/glmRdYNLea1cyVTL0Ow11JvKvXX
         yCotNLWn0LbqWsGMLuBnaOVxk9wYU8ymJqWM0FnsGZO/ELZ+6lLo2lE4gHvyQAVOqW/5
         UIFZHeOzdBY1ZOb0ZPrzzg1TbsJc5eEyMlCFmlEW0r6AiLBdP67fUyu2UJrGdtqVBHtp
         U5DVNIGXCe0ce054z7zs5gj/SJLMiMwY1gHCi+neGjuYIq2S7VOg11c/Nd/mk45jRpx9
         7pMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798918; x=1773403718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYglXmwgP+JSmWsymKCvK4vue0PoG+iaiidSWX3dgOE=;
        b=ReiADyUccSAvZtjvaSt2mIaI79wJP6lc7H9F3Q0rCI6cYiPA5Yr+8mscbuMyIgwfCU
         tyVH+pkHp2QuvLF++SKN05HjawPY6kVfQdCaHYfKuYAOzazSjampjexsPUe1rE18fu2B
         tPntEI0WNTMmLgS9aXzjCc/s/XTP9R4xCjjX+4Nv/jZjsq5aBr5CrXTiB7TXAX29jk9c
         zTzgXGXps7yuZNffG018jH1aH9LFAbJzK7/F6X/GCLh6mODPKVoGPzjrUIbCdnh378TN
         bwUYg5UjBgRAg2Ptn/cCDRNQouOF4mM7rmAcn/AMAuoEh7Ufc54npjIYtirh993GLWr3
         JuXA==
X-Forwarded-Encrypted: i=1; AJvYcCV7kM2fl973bEmWo/mqt9IF0YgD/FLM0ievMD4ZUXils98Z/rmcdP3V3WjvBZZmgOdicEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp1s349APP8Q5HjuQuj4LkNPaBgXZ6a5XberbeOfO5Ri10t27O
	oFiJxdRk7JNyp1QsTkHg29VWzsn6ymCxkaGuL6hM9SYLGVv0uXcSQeFeXe48dCCEfoFXK6FpdHZ
	nUF+MGPMQn604nbV6on2gkf8fkzEQGPQ=
X-Gm-Gg: ATEYQzwmafiIvbzN96T6L1A8sO1SZKYXYeU59y+2RFAOc+Ai3l2E0ifKGpaFIIbFbs4
	o9ujpIdjI7BugWSfkaZ7tukFJRE0UjskFzNx0Lx7M6ugOS/4xdd0+0LpJgW3avIw3jSEhSqfCRY
	9pdR7kQmgDHt4m04I+Ttl1FquH9AkRi13lCBycoD44PqSgcyi8DdU7MAhMtlOhqJc30SMz2f0XN
	jtrRSVOFZP9X/SBPo3S3XMHrmuHmc0lJxtvcfNOotyu69FzlmeWgZe5sJAgQuElrY8kDKG010PY
	7eGj9z69
X-Received: by 2002:a05:690c:c4e5:b0:798:6c28:dd68 with SMTP id
 00721157ae682-798dd7b6080mr15461537b3.54.1772798917701; Fri, 06 Mar 2026
 04:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302071434.311395-1-sun.jian.kdev@gmail.com>
 <aagWYyrrwUt-poL1@mail.gmail.com> <CABFUUZEdbCMrNyp4kEO7A4KZPn5TKi48+tQvaaYaYuJj5FQ7gA@mail.gmail.com>
 <CAADnVQJfDYiBHa4f3p_7MpURE_a33+atRbjbcpZ0VmrKFaKkqA@mail.gmail.com> <CABFUUZHv2a0ky84aUKcqvH3o8x=5jpUtZMW=SrrNiD392e0sQA@mail.gmail.com>
In-Reply-To: <CABFUUZHv2a0ky84aUKcqvH3o8x=5jpUtZMW=SrrNiD392e0sQA@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Fri, 6 Mar 2026 20:08:26 +0800
X-Gm-Features: AaiRm51dbSanTdO9G71-TpmCeTfraSWdfLYC4SCnDtzDoPQs2iyJdlyJ6-pndQU
Message-ID: <CABFUUZFYUrhk4+MYDHajcHr1rU1jKCErw3aqHFq+Zh2PwB1Zsg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: skip verif_scale_pyperf600 on -E2BIG jump
 complexity limit
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

v2 sent:
https://lore.kernel.org/bpf/20260306120024.1032301-1-sun.jian.kdev@gmail.com/
