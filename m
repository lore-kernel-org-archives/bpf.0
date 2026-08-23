Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99A4F5E0
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787495835; cv=none; b=YSML46PYc5pYVjn7AA2vqzV0Gq9EbTOV1zqCHEzRnoKScQKLZx6rernEecUNftl8gFLH//Ho3Bjo67vRSFCGb9J9ytoLgp3Pmgq7zXGLoQCF75UqRewHQsZ76POMIG6JdwhLPMN61yrruO39GpVrwUabWD2gl/t27BbsWNvbwkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787495835; c=relaxed/simple;
	bh=4+Lf74ULlICmjdorCaIwrwnuSldmzw9nufhg4ObdNE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAuCqfriTguCDpEj7qykzIBhXGGVWTeXT0Outi18KqlQxCwS8WsGGBs4ZZD7sfcETOrjL4XwrPV6mVSE7b18cIaqwpxPBzR9VCV8kxPnGBrnxpCxV8TRSgYVzi59LgyIca9zZBea0/fcJMS9oL90di2xkv117FIUvfE31w9Zc/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3896ccc93b5so787707a91.1
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 07:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787495833; x=1788100633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4+Lf74ULlICmjdorCaIwrwnuSldmzw9nufhg4ObdNE8=;
        b=Kv881IBs+ipvo8A2x9CvARWh6/xX+BPbh/Q+v+JAXMX4qcjtodVyxeOx3sOOham5H7
         1NyMq3pj/1W1+9CE0rssNFvkcGGkZfDx7KpkRU2ZXkdEASZVlDPPFLxVGBketOU3NoWN
         at80mgjgErZvXUIrE+4kQPCF4NhiOIOjQNn3ojG+seb7Gyus49iNLGywPv2FBmEx4o4X
         8T7dpjGsmgnZUBaPCWLHCrjjoYZm3cpHdDjyzBmes4Grbn6onQ02uVFnNr/2AEbZq1Pn
         WAB8FPj99xIL9yzMYBPQKi+wRmVRyA27ZHpRI2UtWJaYh2osQ+p2b5J84StL0OBKiye6
         5wPg==
X-Gm-Message-State: AFuF++m0gYxnIjrMr/e3DSnc1NZc6FAk1/ZBb/MKZagnX7DrpvO3LCqQ
	qaFmmxcYfZ6CtjT2tvii2pSdzkaabtuU2Wpfrb/d/3Lx+vNcxPdMVvj350RIsPZItgyK3J8Q
X-Gm-Gg: AR+sD12P71CraW12CP1oddvHa+ws70N8Q27hEufrfNqOBTYbS9ycxCBnNIpBD7gJbd7
	dP1cgKuhS8C6v/pVkOlZcK7zbRFpuNGtH+jHBCMjo0tWgA0MS1fSaL5q/D9Nn2dTYa6aERysM1E
	RquJVojWNqAeJl2Uv6UF6HNDrh4At/awD9kSf2Aln8argFXXYmy7gt/F6hbUjhJ4Rl5hDQBz9jR
	ruS0soo4WmRkFZ5MbEF5zeC7LsVoEKIMYkUJV1n54Yz/ToftUG+BEYcWQB3gCBn/+R1smjwav2c
	rh9QsdTgvus8ViYFRtWsAyIL4BQUITArkJN3TX1tx7aPqIkmpOKJ0h0J1JNTvvw7Ca5CokN9rRY
	NMHf9Mr9ZChQhNwC4S70NfE5lsdKnAKsGBn6lrykAKtowwZBvdYuTG4p1XzaFOz5F5sVQdECzXl
	kMIc8f6/+pHkoAuA1x3J3+gpEELac1UJVtp++4u7WCyB2+TJSH7UXyUEmJmukOr9P9gBO3vnBy5
	QCsBPY=
X-Received: by 2002:a17:90b:1b03:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-395c39cb2damr31159267a91.13.1787495833290;
        Sun, 23 Aug 2026 07:37:13 -0700 (PDT)
Received: from localhost.localdomain ([180.153.160.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4a15829sm6241397a91.14.2026.08.23.07.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 07:37:12 -0700 (PDT)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com
Subject: Re: [PATCH bpf-next v3 5/5] selftests/bpf: cover stream capacity and partial read edge cases
Date: Sun, 23 Aug 2026 22:37:09 +0800
Message-ID: <20260823143709.1184788-1-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815082700.E74B61F000E9@smtp.kernel.org>
References: <20260815082700.E74B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Aug 15, 2026 at 08:27 UTC, sashiko-bot wrote:
> Should the test verify a subsequent successful push using the same program
> that performed the oversized push?

Good catch. v4 fixes this: stream_oversize now performs the oversized
bpf_stream_printk() and a subsequent "foo" push in the same program, and
userspace reads that program's stream only.

Thanks,
Jianlin
