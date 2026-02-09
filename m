Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803BB1DE3DB
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770605583; cv=none; b=kRiQuH1mUz7AEkM6lpnEBu0sO0xB/JycQbgwU0l4dUrfiaCFZC7aGv9LCReO6wEzPNVp5cjnktu1aoQwRa33ar1XiIvuCLHOdvGZuOC9v7VZLsF8ong75Nc1OsNGJTkybP+8YS9u9mw8l3Krt04nPxC142UNm1Lzk/yaM3vLbjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770605583; c=relaxed/simple;
	bh=dJFXZ8N4JWJZscr14sAaw3digTqHt1nANcFmMFYBbA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sWhdc1u+nMCMWhCQ47V+rVSA9gwO8TrmBzgobE6xEd0AgleD14L9Aqb2Rf80ivhmqJ7zlDlrxFzcKWJLiQthlwqnFwF7AOP6Utkh4+GbpQSmRL5wPW+gf0xzt5zdNdCtAzLAOUIk7fLuAvxnBDEqGGxw9uSkVo94P8XMKjlZxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fthIFe6m; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fthIFe6m"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-354a2d107bfso1116242a91.0
        for <bpf@vger.kernel.org>; Sun, 08 Feb 2026 18:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770605583; x=1771210383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PcQrXxB8xFn6uOssbnZNVp5Np7J4WmkCCnxi5G5T/ik=;
        b=fthIFe6mIB3lavNYjMY29p6eQBfHltaPOa/QlQ3e9wPaWCVXxAItT01GlLHiWSkb5a
         IHvlaHv8oEq70K+h5QiSD6tRY7kR9Y3GxnN5ixZ5qvjLJe9kPO89bKj0ztuMb0dx1hk7
         iibT/jJOIowfgYjSttA4zRMLV7RVMCpendFOEpQ52bCV2PZT4YZKnz2TtJIe0EA40wvE
         /6Vu1d5RsWrSBFLvSEIu8rV+ez9ahwtqttEEkOvKWevoa2KuKFjIT1qgbE9OLS+xcTVl
         H9z8XE64o6sEzQ9Aq+kuLfoLNuGojLxFhkhhGDQNj6r51sogRqFJdBMunC0SjPuCOL4N
         1GQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770605583; x=1771210383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcQrXxB8xFn6uOssbnZNVp5Np7J4WmkCCnxi5G5T/ik=;
        b=rGC7M50bAnkCCzTp/oF9ImX1ITBmV+VO1JLLMx+Vhq5evtRoj5ZjwexsWccfxGiJGB
         vRX3hKJdXnghrgvlGIIMF7WouBpEviGY3sf8WAN68VrVztjSOL6QezBdE3xugFja8jn3
         hJZAJNtaXWtSHOnVtwmNI6MiLbVUPzq7RaFib6YUgTQCoETB3k1Jq6cl9+ixeDFgT+9w
         4xBmnN1sK+yEWPeftmxKVQ/Qldxq+0s5BqlMo57+GurH01+vy/nbsOeeNj6OAsxWh9P0
         dPAw9OOMoV7EEO/xF5eSGkiDfDe4BYwu/WZ3ePtHfbbwZZIMvsJ4E1Jyfb88zM5Bx2Jf
         Uitg==
X-Forwarded-Encrypted: i=1; AJvYcCWHVeWhtfbey6NHqQq2M89QwjpRNUkWXv0M6dfWVX+WvIYJNgvqxkfyjBkY0Ab+wnxG8Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYB1tXcM6OhUghTBSnk4OxHUXTByOATcWUuBzqr18PMeOCSt7K
	qaVG+5QdAQiFrMI1l7EEx3akYEAcR7vz4eX9PYhT/CmfJhUqZCa2vzrc
X-Gm-Gg: AZuq6aLQYAErqRUP94i+efVhs3BJi+r9OHFLQDPAW/Kzgfl3yvGjdMN2Z3XZLDbzbA1
	LdT7EARJ4L0cTUZrVoax9Pu6ntqq1Nxbj4R1EOr0Bbu5tzsYWIJ/JbPcgfTmA2LAUKIEh2owPLu
	JF7TBnWgHvuklW0DJfXWoX0K+X3hfIDAD+yYbIgaQYabKUDGPaXQp3o9tsAaFbE9t3LBWuE4hCg
	RZL1SyhK+Y+QLZoMPPwn5Br3yB9/nNrfMrSJseuqi6lqNwOvldaPpGPQPG2NYHB7wqoh+0niG3m
	IG8FdPtzUbeNJ6dR6EoqHdkuLlKirQzfb5asqdEuso90HiqRpah6TgXibVf+mcT0YAdfL1RlVrD
	m7D+tdMgxO791dv56Y11o/Im6XFX94c4gy6t/kz9LjW9Z/wGkmqI1liU+TRwr2H6cNT5NhhWJnq
	6DX35eDJc5Z0RoKjzmL9Bjen78gfaae7jtsHCZ9OKsWQ==
X-Received: by 2002:a17:90b:5648:b0:356:2c7b:c010 with SMTP id 98e67ed59e1d1-3562c7bdbc7mr4273704a91.11.1770605582741;
        Sun, 08 Feb 2026 18:53:02 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35621177896sm6302649a91.15.2026.02.08.18.52.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Feb 2026 18:53:02 -0800 (PST)
From: Chengkaitao <pilgrimtao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org
Cc: chengkaitao@kylinos.cn,
	leon.hwang@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] bpf: Introduce the bpf_list_del API
Date: Mon,  9 Feb 2026 10:52:48 +0800
Message-ID: <20260209025250.55750-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

In BPF, a list can only be used to implement a stack structure.
Due to an incomplete API set, only FIFO or LIFO operations are
supported.

We propose introducing the bpf_list_del API, which allows users
to directly remove a node from the list if the node pointer is
obtained beforehand. This patch enhances the BPF list API,
making it more list-like.

Kaitao Cheng (2):
  bpf: Introduce the bpf_list_del kfunc.
  selftests/bpf: Add test cases for bpf_list_del

 kernel/bpf/helpers.c                          | 19 +++++++++
 kernel/bpf/verifier.c                         |  6 ++-
 .../testing/selftests/bpf/bpf_experimental.h  | 11 +++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 41 +++++++++++++++++++
 4 files changed, 76 insertions(+), 1 deletion(-)

-- 
2.50.1 (Apple Git-155)

