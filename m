Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641066;
	b=34TI5V3WN/9rt5nuLARI8ZKgv2yv5B+LV/5Zq9JFh9wBDdtrMsaelUxwVDsqA2ED7kcQ
	 rtE2IsHSba2v5vfGgFlev3rY2JFqfnjLEFFX++7ou5M+nNtq0VMEZoZH4SQUXCXnqrVHe
	 lBCcUKJRsOn73+hGIb7S7Myh6Cp3dw3m41KCJRf3RzkThikkMRiGfMSGMp4NmbTKJ9z+n
	 PumUdOwEI07vd1NekH3uS43yhbjTy1I8sZ6W448N6ghSPdMbQnF89lAcQzXGoAxruUpJF
	 Eveqaq6+8TleKyRPmlI3tnMjDk7NVtxx+OMKjI2F0KUt55ZzwSZCH4ggrUKOk7ZubRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=qXqRtW1syoiLdd5n53NdwfdHCOOIx4QPcuTUmqW9yqA=;
	b=rukbQ+38PULSYX07/zyXUTqqcJ001ISCJSAVJNeQGUPUTADiaiCnosr7PdX7esk4MjjA
	 LEXz+zzlLKnyayOalQnwSnNkBOYZy2j5m1SO/SRftYlPAlwpmn+QMh4I5wF5snKF8ABwN
	 wwhEuf9fN2zJHxZNvlqinEGGvh4VXP+H120Ym94tK2a4lNpvM7MbASTDeN3VZciN+kN9w
	 2iYSXd3pQ/YDQcle22D8mkkpp9Y2Bh3dBpBqaYATmZB8+nteJ9LN195BIu28RWSjndE/U
	 PWvNNtVW1MkWV/D1iI02g59YNKqdukQIq/px8BiTZWR0E+CnlPGapHzA9/viwiUoZEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zUJN8SED;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9A1606A90B
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E9A1606A90B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zUJN8SED
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so2389001a91.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 09:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793641066; x=1794245866; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qXqRtW1syoiLdd5n53NdwfdHCOOIx4QPcuTUmqW9yqA=;
        b=zUJN8SEDm++WOQOorvjsTMDG4CQ2NqjrJJBJytqbZVaENlP3BzJBaEtmZzUkfrosfj
         hDXcDHC25sLEgd0llWRZfs/G4mhQqmav062ZE0oznxmlKpNxetTTJ00wZlPImV9d1FpO
         FmNtMvke4JZUErvodUkTRwKXISNZqvteN8qMDf/uhN6uK+A3jD2ef3G1ibEGcCW0f5le
         WMZri50DHovPGSBhOA11/n3OJjE4cRkKLuAsLmStqBE92zEbH7s3Xfw1B0jdGtyWP6PT
         JOeUooL9NyK+mlUiXYHzc5s3fXQ9BkiUP/a81Xdllc3XSirYITUTTjwapRa2OasZtqwq
         xwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793641066; x=1794245866;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qXqRtW1syoiLdd5n53NdwfdHCOOIx4QPcuTUmqW9yqA=;
        b=IKWlCxs4CAGAF+5lmTmn7oxcQDV9PeRZFWL5xOKA0T1a3RvrFtL+aaEzLTv0WgsryV
         pQh3BBRwwwJG88aPExdWIP+MrGFNoCp0zy6iSgnUxZoAIGTBiaRTlz8hBkz3qZUhPyn/
         B2H/97FDtfJNHC7JNVSd7Fn4J5EiPpfkyEFtFRLCpu3Kgre5a8+mUKzfMCJDTlE9BOOV
         +dThsahkF74waGhrLzoFSIIm4CgQJhebcYc7Ubbf7KlXa1MW4jc4ZxvFsnsMBAEJonwY
         z+SmCAx34pSKjXyUxdn8Et8AW7VQg8AFzdbsyETEBi/NtBh3Buk8e6TMwqF1UdAB8Q5s
         KYOA==
X-Forwarded-Encrypted: i=1; AKwUvBzJEjowZvuLZSjl82eUqz7bap1CIXSlKL/rSDfrQVKSqU2kSiMluRYNxAvkAgN6FSJKb2k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cPgFC8l6/MeSyse/e9kcKQB3llWERdfrgAYv0MciF7W1uVvOa
	gxjM7gAs9qBHF6MVTh/KsRRrQsi5cs+Glmo+OFvYoE1/wYySav8bSgdt
X-Gm-Gg: AYBFou038dsFNuD/YS0GW5+yofhmDGzDxjw616GV+ftbNZ0NcziSnQNxNpVX6N7fwxo
	vANq/eeVq0qp1EDKOPgTsxriMoh3aW7UiDHZyWBwRzOBFw8Eg8rtsxJapwyai0RI20Osf/b2pCc
	1cXMuz+tlFcaA9owUJkZ6XaB3SQu8p1As8ow5PeogfOA6ZBW9tWHdHJEIDU6tIPZPNn01kBkbyn
	gJpAIhGJhqn56CbEJrQUppHlOc03biIfBLwqpYin+Vx4MVPQMn1bSa1EH6ucCIthhUHK/QUgo+S
	8G5dvbpKvn0nMV5bt6oPAJRPQt2178Sqf3Q10KBJNFZXl20IxeMcE/Df+i4qQhARq7MZB+XBXwN
	050dMGvhsPyU05M31853+iiN2Y/OoO0QipUT0cb6sqXHT14LMBKknzlEij4AmE953SLi4R1MIa3
	esNw4nggsHJTE1QRT8nBbUk3TE98QmYOwjhI9l3MotAjRo6rkIcv9CMVBOnoXRaUlCpZ0jDxJ1z
	YHkBIFbBFmG9kSOluCBKQWPSzE9TM5mdX5kGKPYpIceLQzvBAMmY4onAz/8rh+r0znOeBdg+vHU
	Ys413BZtU2bXRNwcv9hXB0cU9Ppd40KF/cF8HaAsFKxiCEReBjnq+KAE9lUAlIMowevpVYOdFS8
	Ga2Qyqsy8BNThbNjNiHQsHyVdbhhg/ycrCg==
X-Received: by 2002:a17:90b:4b90:b0:3a4:7730:33dd with SMTP id 98e67ed59e1d1-3ae8984b662mr9027582a91.58.1793641065642;
        Mon, 02 Nov 2026 09:37:45 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm146668a91.13.2026.11.02.09.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 09:37:44 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 17:37:43 +0000
Message-Id: <DMKWOXI6X2IX.1UVTIO2JK7LHU@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test liveness of an
 implicit kfunc argument
In-Reply-To: <8581ffeb7c773e5dc931ab99c0fd6a7cee06a0771aefddce1183890550402cb7@mail.kernel.org>
References: <20261101174405.4055052-3-alexei.starovoitov@gmail.com> <8581ffeb7c773e5dc931ab99c0fd6a7cee06a0771aefddce1183890550402cb7@mail.kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 01, 2026 at 10:31 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +__naked void implicit_arg_after_may_goto(void)
>> +{
>> +	asm volatile (
>> +	"r6 = 1;"
>> +"1:"
>> +	"r0 = r6;"
>> +	"r1 = r6;"
>> +	"may_goto 2f;"
>                   ^^^^
>
> Can this build with a clang that predates the BPF assembler support for the
> may_goto mnemonic?

Not a bug.
clang 18 can't build test_progs without this patch either.
