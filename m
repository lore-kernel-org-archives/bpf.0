Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F58F6E
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711956742; cv=none; b=r5cGByxuZSUNlNNxvlS0GXvBfvmI4tO52oIejLEQoN6SBKApzGJt5DXh+LjAiBLvZdoLVJGMCKgkZJQcfWjYx7ZaY4KLYc96R0ZTnAG/0GcxFWOj/m1W7P8yFc7RcDQ3KJ3TKZ9WtT8jSnADS4IaNt7ZPriHr2RN2C93pdOJ3AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711956742; c=relaxed/simple;
	bh=oIq/k7QSNY4VXE5qTIzdmpP02YxKDabeCib0tznAHpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Azwwhp9kJ1mKhznCt6iNgyUfedXXjD7ceEBiM0+IgsR0lOh/iirtuTbI7YmBXvKD8PkWItMtEFGPMk2Oyi958ghK748+SG0vUCRLM6ktUtAU4FkTm59VrZJPSABK846Jndx+MgVgmVVnBLrpNW/Ihw3dfIhpyway5+qDK03+DPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=hXhTFi3Q; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="hXhTFi3Q"
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CA62242492
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 07:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711956729;
	bh=QCCLiPNOxpS2FShA4qPYs8euISrDLAWIFv7k+ZCMiCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=hXhTFi3QEJzAAq4+Q42iXVRbDjuUr/mcoJdGfca7tu7AvTYuvFNQ5yRsATV8VyZU2
	 27DYTuGPWVOMDrj9nyNWjbdQqlguzUafAm/Corz/FsgY/MvSgdjesT7s2xz764VJgq
	 Dx/FMWpGCzxnlMVQq2IGfSLzo84d2OUwBW7xdLNmA3BoPhjy/ZdytNReWW3jAomc/5
	 zDhfUTlyiY802lfGypKVopHcREW94BnQueD1Ne7YT6HpXnESwNQ3t3A62m9t6nLyjE
	 6n+T0bPWJckvb5nS3gO5KVPIx7R1PpjLSp4bxxISS8SizkFiuf+WNywjWPjXhLA3rA
	 VxPf+nwgmA+hQ==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56c3dc8d331so2916230a12.2
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 00:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711956729; x=1712561529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCCLiPNOxpS2FShA4qPYs8euISrDLAWIFv7k+ZCMiCE=;
        b=opzko8xcQvfnva9mkQvoVjvU6CLjLdjRu4GXlyJBBost4EcLH65FteY+Wisly3GfvO
         M8vHOUPe8+5a+Lw+9pa3aluq9KHJEXUp/O2MG3SNY3OLPA4lAU9L5SJ1kxvgWGVhP53b
         F4fcj6Eu9v8Haibws2Kug2QOBk6LPgFhtxP+NuQfMN8M6EagZosqWzd4OocgLATMetNd
         t5pCb9vcB+GlLVNhNQx36kxViC7UAgY0YHbsh0QQYp7t4dPGEo9ulDD083u7F4M3yTq2
         dA31aqj1DrTYcoLSl+19Gz9zgD+59gVeLL/p2GZyh/vfR4OXAl3S7a2/huv9vQBsubMN
         LXRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4glYsOLYrOoM/X+76JBLOyAulDyt6hLCkeWN1q7NCm+9g5JLBMq6k9Lwld5p42ka0ZgQHm/cM/5RMQT0mO6wEev/Z
X-Gm-Message-State: AOJu0YzHDCPbWd7fHEtgk8Ll2A2E0JlWUiHiQ0hMVFQBArJzxfhdR17V
	PB1ucOlWiapyo7iy16k/kCq+fEhXHPB1Bg9MhFkIpgPiyExYitrLaHLjrCGU1sxfDM+Pb7WHI2n
	6buTzdR0+JTEHAhnZ7KPOVHeisbUtoq2jlXJkhqeiglbQV7urTgSbA1NVg/hQpkutOA==
X-Received: by 2002:a50:a697:0:b0:56b:d212:b032 with SMTP id e23-20020a50a697000000b0056bd212b032mr5327011edc.14.1711956728196;
        Mon, 01 Apr 2024 00:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh1G5/18x8uzGzn6AJKqdUge4eitCIl9bM5TJUhmqS8MyIFBBJ6d0fq1am5zXZmHiXsXlg7A==
X-Received: by 2002:a50:a697:0:b0:56b:d212:b032 with SMTP id e23-20020a50a697000000b0056bd212b032mr5326998edc.14.1711956727672;
        Mon, 01 Apr 2024 00:32:07 -0700 (PDT)
Received: from localhost.localdomain (host-95-248-169-71.retail.telecomitalia.it. [95.248.169.71])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b0056b2c5c58d2sm5096511edy.21.2024.04.01.00.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 00:32:07 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] libbpf: API to partially consume items from ringbuffer
Date: Mon,  1 Apr 2024 09:19:00 +0200
Message-ID: <20240401073159.16668-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce ring__consume_max() and ring_buffer__consume_max() API to
partially consume items from one (or more) ringbuffer(s).

This can be useful, for example, to consume just a single item or when
we need to copy multiple items to a limited user-space buffer from the
ringbuffer callback.

Practical example (where this API can be used):
https://github.com/sched-ext/scx/blob/b7c06b9ed9f72cad83c31e39e9c4e2cfd8683a55/rust/scx_rustland_core/src/bpf.rs#L217

See also:
https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T/#u

v2:
 - introduce a new API instead of changing the callback's retcode
   behavior

Andrea Righi (2):
      libbpf: ringbuf: allow to consume up to a certain amount of items
      libbpf: Add ring__consume_max / ring_buffer__consume_max

 tools/lib/bpf/libbpf.h   | 13 +++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 tools/lib/bpf/ringbuf.c  | 62 +++++++++++++++++++++++++++++++++++++++++++++++++-------------
