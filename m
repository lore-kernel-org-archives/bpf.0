Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABBC3D16FC
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775745656; cv=none; b=TFDWWAlzSRBl66omS5pmp2JEhsm+MnayzX+uzzlwjI2cm3juQareHUJxDVnK/Ki1XSoGutKJa7y6P/MZV2rf3lqbfyNYode43fS2brhtbECDOBh2SyoTMHF6ipj2NEy1j8r5pxn2zn/SHRXTVJxpMo+YNIDklTYnq752jBzWGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775745656; c=relaxed/simple;
	bh=AouGHkgXdYe9anG9SbX/UJnI/L1Ht06pXTIqPlV3qiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACKnvNCMRBwXTYJlg3oZKCBY5dHyG9gFJiDmnP5LNxNEGhS6LddwatVQKkSvnKUNh39/2wCjml3i8DrWdxKZ9zD3nHSDkxIo1T1FJu+aguKL0aqaIgeJ1btZVSqGzzqsO3tZPgcKEBc0bSOXnd/5COEn6O/1sKb7Z41iyXXvj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4kudXV8; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4kudXV8"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2b256a4c6b5so6135575ad.0
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775745655; x=1776350455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AouGHkgXdYe9anG9SbX/UJnI/L1Ht06pXTIqPlV3qiU=;
        b=G4kudXV85Zy5Beb768hB6ozQ9L9xN7RQM5iGTnxKNylcS/2d32ZEKi9vSZKsAhfvAE
         HOKRgBaunI70XmF6EVyKUAgqJPR0Bx5HBAdFFHcvFnPzwIm36VjwFJDJLxVmNWRwqkyV
         9MLpAqm/rouEtIPcctQ7Vzu0M0cSQMPG6qXcvtO/pu5OoUUryYLSBSm3IDxvNsZtsJFu
         UYwC6rVi7xxLXm/t5v4ZP4EpWjKnVMCbNLyl93gXqc40x4P92GEls/iP+6FSM6dqJGJY
         3C6KIjAqU5lhdUZATD3d9/aAVCJI3YREQGLUmOFZC26FjK1x+zY/01glnrmUoIQPs9Yh
         EvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775745655; x=1776350455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AouGHkgXdYe9anG9SbX/UJnI/L1Ht06pXTIqPlV3qiU=;
        b=eMQeGlaSz+YziJad2OUVwHfqYgjx60cf+6iXQFuMe3iJAtZBBMN3WNSRMpaXcvYQ1v
         a1BAvwtFtEhgZJK7EyrrHG+YQc1BT+DclHltnGgxXCf4SbdRN9e24cNPzu6ZodwQBwtH
         +UfBJKARDaD5TV/CWd0QviGMn1TDzln43Ukxo1PXAI531NE8uzKJSX3Bd66mQU7PVYL/
         Ys0kI0b6TFKdKjvbChUXS7nzsug4fdaY/ipDhHOu53pDmuX4qzfDT0JJMAFScHyOJF6b
         /KPI/EhNylvyT7QOg5EDTJPKI0cjx6VE6Y5ejORvyCXeyqTYvHTzs/9u0SnKkkk2wa5g
         lAfA==
X-Gm-Message-State: AOJu0YwjYwKh1WvHtGdmBUfULqDadXrShB8Kl2rgN1BjBpWXuxaaf5rM
	7JBWHKB/Xkl6TCB9qrhUHk4nd/uyvl5e2f56zM7sSWfdSTBcCGuM4HtncafBO38w2Q8=
X-Gm-Gg: AeBDiesMifaLw/r9qjBm67aJqFiEBJdqTtv+v+X+5OcLdylgzxihWMXQKTc4IBR4EEK
	j4xAtUwjhmZDAVBjcckH3szgAjC4YDMLgu+tvdqvubM/5mK+/m+KOFFIHVIe6llTDv5BgClRHNu
	oSjCcMh3CD3CWHd+8/7KRLtiIiSDvpsi52hQer4YvmKFOtJboJE/c1cLp7i4XO9hLqE9+U47WzI
	pOGzgtB1JIxsDOayzQAcdl+BaKW5jslMMQx15bgZfZyzBwQgS7uWCNawpiNF7AswOcWRXdVa3Nb
	iOMvNQ5pvctzfW3BUuqTbJ+rAYDrstaP5r89BFy7zFKxYTDAt8PRR14izX5d1b6v/MaoyFzPtDm
	kDTDUwceGg2LIGecygzW8WvUJcpkwW5nuz5vATU63vNL6JnB4pOKfvZEz8cRClcoyWjlQas6aZC
	pdOG3Seyhxnstm2IssYyE+
X-Received: by 2002:a17:903:1c2:b0:2ae:aa16:acf7 with SMTP id d9443c01a7336-2b2817bcbabmr255292475ad.40.1775745654694;
        Thu, 09 Apr 2026 07:40:54 -0700 (PDT)
Received: from laptop ([223.131.147.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274779b48sm335511965ad.25.2026.04.09.07.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 07:40:54 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH] selftests/bpf: fix const qualifier in fexit_bpf2bpf test
Date: Thu,  9 Apr 2026 23:40:50 +0900
Message-ID: <20260409144050.374405-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <7967c952-3922-4b49-953b-530b80850aa8@linux.dev>
References: <7967c952-3922-4b49-953b-530b80850aa8@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the pointer.

I missed that commit ca0f39a369c5 was already applied to bpf-next.
Sorry for sending a duplicate patch.
