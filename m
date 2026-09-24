Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91839E18E
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277598; cv=none; b=iTomNgoOH9hxbMF9iipzOidyogymokqOFmZ5gwrqmAUXU5/9KW6z1MSS1Xz854yWrK8sEQbmPKcBA5XJwDMcRVMUT7UpaOm5Abr35ZF/rFenzomdUPFIHdQVEdV/9C+rW8oVGDnQX+OAvfaTPp5+ZVefDJBvtdFp6C9W4xkwKF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277598; c=relaxed/simple;
	bh=FXaVo11Gus9Sx6sFSQ364XFB72gAx1VxL2xi76KwxYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avScoev6b/BfwfBWWMETjsG35znZgR3oyAAHon6TSOVVHjYoYVe5fbNqVSc5EOaaYu2h0Mdf1Thc1DI/gLYIGyplM0PnnPlZvLn9x9sRS3NTj20z1ZVehZqVqntcKYaebxKXFgT2fLMPb5+pc4a65TbW/OxGMQUyCamJwwDi7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5bDW8Pu; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5bDW8Pu"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f16f15so145657e87.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790277595; x=1790882395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FXaVo11Gus9Sx6sFSQ364XFB72gAx1VxL2xi76KwxYw=;
        b=P5bDW8PuGU4I6matgNRQqLrpv0vhCR9zBq7Cyp1TKabu693zeHL1+wrOHwqxo5ilg6
         lDzQmWOSJ+wLh+ujC4MmqoA/DA2U+8kR1HhZk3vZD7W6ghqKCS1MDJlAmMu3ozxpsrQ7
         Q2VddRJTUirYiePyO1HkrWpsFKqapNXvQNQZ4dtXyNuXsHs5p1IvT+TKqwnmFP8RLxpl
         Ww4FFs6NNuHL0yiMsSNtPeKdeeWSaRic1EfkOVqz7ch+PznTKc1PmflERymEoCLcy7og
         hT9ZAmvSQInagUMYOZVfx2DcviPLFhDmV2tiYcS1lTw5Q+kPtao9FXrEP72BIp/0mZcQ
         Q/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790277595; x=1790882395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FXaVo11Gus9Sx6sFSQ364XFB72gAx1VxL2xi76KwxYw=;
        b=fI1SCozL2KfcZsUALkG7qQVcf8H41ssX7mLt44naWq1t3IjPakhJScLGzJganPg9h6
         UqWJN7QhEuaIUaRM6q7eUP+1voJJI8DLpENnj9bjYylVB23NxlKlGvheNtXiZxKjPqKm
         Hd9xmptYJxusGws+mulc+Nj4tvK0HO76wbXNyRUvTYWf8R02ogFOmgDDJGgf319pMacl
         wyPj7SjysiOetan2C5LkJInNME30yGqbhM/1oDlITcWssMPXmpFX5vL2ZMGlOAAYLt5A
         ldJH0gv/ehhqKR3e21xY0h8B0OPOu7nFf0RE/FUFNlBXJEbkyfBAbabIWxValAsAPAB9
         1Lxw==
X-Gm-Message-State: AFuF++lgNurUwhAI2f/muSdMqSreTnoBpz1ORaQCjIkKImk1g49Amyg1
	Gh/iHiEs14e057gLg7PPVJICZ70s0I6RW0K9FjO/kH++ERhw3dlC7ZjkVR3wNt6zxVk=
X-Gm-Gg: AYBFou2rBvc9UINtQXSI04LW6eWrFNdzbHE21LunU0B5je5O16Ew5oVkndsZEhTbgri
	qW6hO4lCw+6sPn8WUpqvByulE44XA9M/qt5mXjIg7q7SMIMA5nTFS+kYO+3Bbb4paynyeVOgdjr
	7LalkfvwQja8pFWLQfLhu+orXsGL4AHZ4Py9NEgHJcn/TLQ/VNunc2II+CqpC7c1Ba26K5b+CyI
	HmcLMZ7yoTZ5MKJ7a5R8kDXfYZfPu3mmRHuBTllI0KVWvL5mc368Ke3khKQ4iYoYvEwT5lOc6sk
	8yqNpfrrAJxsfMuPVHDklmaKhXxvjnPeXLf588uiHLRRePkTc4+ApFNLReKXZcVTReB4UuEqSoj
	TuVPTOiGCCieo1FpeAKhpZx579b0W79WcihZu1R7910xOhNwDcJF9shcdA29dbi+yHyjKJ83MkW
	f+efnnkQVgzs1gqK82cSbpBqfy9wZoIPLzcK5q7Mc9zAInG9SLVWAopCzO31DgrQnfcuIZP9kcF
	I/rNnjDswu0UxNT
X-Received: by 2002:a05:6512:613:20b0:5b8:bc5e:d116 with SMTP id 2adb3069b0e04-5b8df0b5871mr989865e87.64.1790277595016;
        Thu, 24 Sep 2026 12:19:55 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.131])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e68eec94sm13911e87.69.2026.09.24.12.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:19:54 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bpf@vger.kernel.org
Cc: Maxim Skokov <skokovmaksimevg@gmail.com>,
	qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuba@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Check that bpftool reports a map it can't dump
Date: Thu, 24 Sep 2026 22:19:35 +0300
Message-ID: <20260924191944.548447-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b5fb457e16a434d457a136a5d9286b1163fccaac99804e0f88a370a1a3b06805@mail.kernel.org>
References: <20260924160732.485650-1-skokovmaksimevg@gmail.com> <20260924160732.485650-3-skokovmaksimevg@gmail.com> <b5fb457e16a434d457a136a5d9286b1163fccaac99804e0f88a370a1a3b06805@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Does this multi-line comment follow the BPF subsystem style?

Fixed in v2: the opening /* is on its own line in both new multi-line
comments, the one in bpftool's map.c included. "can not" went away with
the reworded comment.
