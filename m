Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1494EA39C
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788661; cv=none; b=tMQy8AAjZA6Tah97A920RntIIedboGALWzIBsZskIt4sSdbGIbqqUgifSKz5s2qsW17LrETqqjn/V0y4Xsi3338ZZ6cjdzlSa9YaAg0v4/THcotS4ppoKbJMXOB/yHnMd/w/7kckISO1KRfe2ZXTasXfvtolVF3BuQ9ReqZpy+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788661; c=relaxed/simple;
	bh=D/v3Jz7xvaKh59QLJ99lH4pZEIIORIIk9YVsyFYrUK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnpI1Vpp9319r+XIBZKEUX8IGBia1I4Fd2b8vRh2qL75cQV/lYcg7RBTw3as27hkjD+7RdL8QNALvOczueqSIajtrJpdWNPwHsT4/D984/fRGTFx9eNGOWBM72iCauTpJtO3OvbltVCwfEeTzBH2E/z6+mbA0QxHqkkLzICxGko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOZF4pNQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOZF4pNQ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38759bcd877so3578091a91.2
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788788646; x=1789393446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D/v3Jz7xvaKh59QLJ99lH4pZEIIORIIk9YVsyFYrUK4=;
        b=TOZF4pNQt12wS6QnSKbvulgQXIqYVaGnobubzBIHeWf/X3tkOXgSUQOlBVAj571A71
         Hmo1LptUqM7eKK7oz3SE86ctlvvdPO35/HfUez02OjhUGPjAE9Xitj9iz80VlUjyn4CC
         b78lH9yJCOi3kS4WXFYKP4rdUStbUJEnN1xWoCOTRxrdRSk7sXGMeop6lDeFN27yKQhj
         gMbG8gb50Re9LzIdXU5fOfWL389Qf5W8IwxSCiNL7Ntb52EgxOTtfFNtKF4vI82xE347
         GwltUC8bCoLAYz7Y3RsWSV+xxY/26+BpixpprahVU/i02QaH3UfVR/hm5ytVVc1eHWfh
         vyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788788646; x=1789393446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D/v3Jz7xvaKh59QLJ99lH4pZEIIORIIk9YVsyFYrUK4=;
        b=gNlEum1WwaT9q/KdZJUeUkimPoOICtIGM97o562sHI1RvgniRpIwZ8IAC+IEjxCKp7
         T1mEpUpkWf8XeM1Wea8fIx/jRss9LamX6/UiH3vlVBEgGSmsHf2+MVSBTDZvUDCh2NPB
         wpvIeoSlmC6g/6ze3/C31eAIXmdIj1malhP6Iu94xN9PieVbuJJrnkwaMSZBbaMBrPGt
         MB3O+Bty1qy1d282bfFoeAY7asL0VoFe7zoKTz/cImtsAC/MWLMFU+iCwOTA4ZggcFC5
         GH8KIS8xNyeoL6gBzbIWYwlIHK22LeTtY+23JwVaFGvMK0eSjK855t5nNa1/noT2Z3hZ
         M1Mg==
X-Gm-Message-State: AFuF++nuYPTRbQVPwRrQt4CtNX5iv+W+N1ZlVqfiTRwGZ53WIGuRx/8y
	6mWCx5Xbv7TM/35tBgPe/1ToemxPqBO8rFom7vM6bwY8F0G8fqPP4Wc=
X-Gm-Gg: AYBFou0bS9BYi7CoOFAPl6Aj1ugSPFxi9zK9BzdGpH/K7R527nZ2zsQU+8K0bFb6tpE
	HDPoPky3QcD76RBa1As+zMpJafKk1Ugfagm0pWrm/WoPSqBAHAixtg6yt2RBmkSyPKsbhnUybKm
	qE0FPzXEdl1R6HUiU2w60P/HxVobqDE4Vre201hpPmw0RoGjDfeMjHQFfGgKp70yPiHrSaNZxeU
	Etp6ibJKMJnMYdupkR6i0f9UnDr0wFqBOXnqbhIxDSZnEd9qeL99qNQmHetSxjx8etnRqwikoDZ
	Z/vWyiaYp2g2VD8UnoXb0Alm1bu5SED0ytvexVPJ3x+BdAsgqfIR3GcsJ8l+4IKvspXT66ZGavd
	vTq872ns7e8z6K5oPcmpE9QYZWd4+dIakQlLKKt4kWLlBqiLV5Tyo3leqBF/0GwYauGt7AlqmUJ
	FAPddbeKwgq3GR7ETz0w8dSq+ScJmaIpfvpqzYwpN3ztIYU3ORjpJ9+CTuKirCH+WLLV4++wCaa
	tS1144ywRhUm4j7
X-Received: by 2002:a17:90a:ec8d:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-39b26101c08mr33965509a91.9.1788788645675;
        Mon, 07 Sep 2026 06:44:05 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2612d3f1sm20717513a91.13.2026.09.07.06.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:44:05 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH bpf v3 0/2] bpf, arm64: fix the exception callback's frame pointer
Date: Mon,  7 Sep 2026 22:43:55 +0900
Message-ID: <20260907134356.616964-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907130624.611942-1-donggeunyoo.kernel@gmail.com>
References: <20260907130624.611942-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CI reported CONFLICT on this series. It applies cleanly as posted: git am
of the list copy onto bpf/master, which is the base-commit above, and
onto bpf-next/master both succeed.
