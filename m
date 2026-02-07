Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB04222582
	for <bpf@vger.kernel.org>; Sat,  7 Feb 2026 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770505643; cv=none; b=RCqBo6bmFQggiJ3byJGAzNNN8N6D92AfAkHw/B7A3Qp/Z63Bt18qBwFrSIwnEnfvcWW60Ty9YpPeMBXIpp0GaT369hq4wfvLOyYWBmX88cEi7Lst2HHwtdAVBhi8TSLH+5gLUWgd+do/qQHz1T2Gmj6Iu9dGcWgdjLuiirZFW3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770505643; c=relaxed/simple;
	bh=g4zUcjL+IMNxQOGpDOB0zSkgb5eh8GvCHkyo5lc/iBk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V82iZvnHnpMwAcBXnEr3x7AbjN3nihBv/7uhJ7VKZrWFNZiCHae24qdND0QIpE8eVWGcDtC/B4rjPJks4ruZ4TmUqfpFZhp0+t9aBsQrxLoxLc8kCn49hnFc1r4m39dVK347J827NPAhO7kgqxU+Qkym2RsZaXdX9jleFtmn5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jxRhVR9c; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxRhVR9c"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35626b11c51so241061a91.1
        for <bpf@vger.kernel.org>; Sat, 07 Feb 2026 15:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770505643; x=1771110443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bxowFVDQC2tzIlz/ZNwwGyDypNBFzJ7/DmR6pBnv9eM=;
        b=jxRhVR9cQrkc6d35dV6+RS0LOj7sGtFGbNgn+H8jBNWXXCkhrNUhK6o56BMKSqbtKK
         KEKBR2xO58p+W5ieh6r56XV1OlqsPTSxyj0kb4m3WKHKMIIBopsRkizf7LGuKdwbX671
         3STY49fpPq+8xtXGy8WKsFY8gx17DXWp0DPZunaYAIpTkgZB1Gz5alshLxxB2pDZC0w9
         fMAK+Gxj/hjwUqsGNsYQJAJKEvj0EFvQ4EMXwu4ovITmLBK6x7aYQKFzpTEg2cNdu6/2
         PM0ihs2WVoOh7GvXriC1j0vRlGXZQX/uWOvzdF2jbSwjSuP8V25r0RNkVLL/OUCzKZWF
         bIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770505643; x=1771110443;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxowFVDQC2tzIlz/ZNwwGyDypNBFzJ7/DmR6pBnv9eM=;
        b=r9AjlvZcooEXfu0BpNp3JvTZG4NSkru4Yqv1e53eQ0IqDyd8pCecyomB9T4vv616Bm
         KrLHlXOYp5NHuejCk4RPRkzq9MpintEVWUy9JGIspyt7KNTaRmEXNkyM7p8U4h3yF91/
         z5T+ggDf0VmHzY3gE6zJBLmnHCeoiq2468Hfiy5RYtbk5Bogc+e0gkzpBa7sDFEFx2gZ
         +KOm5ooHO11zZRKTo0jVjeYKwBzEPpM5MvfTWmV/de6zGtXjRcqscRuG/rFxR85zHVY1
         8ZVda5w6/X0hZHG/IY7n0d1xSYUs3blANiJeKJtZChmaEkBAIXFr0aqI0b09hf+9HSck
         0JfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdiS+sPs6yyXVWQBKkeZOMCiV1n/oo5xz3gIrVm3cRHi+LdjE9rqngGRbtLKr4ydXkD7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD85UhpipCnrTMMsrW2QJGB7ulb7v1Z+tIcRafnS2ig4jt6Gw1
	nMlnGLSCANo5lRmjYRKbouxXheSnDYLcYC6uWB2zO+grQDr4kL7pmGfETG+2mNCjWvYcdKoKpp+
	DBozjqg==
X-Received: from pjbfz3.prod.google.com ([2002:a17:90b:243:b0:356:1edc:b2a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d8c:b0:356:22ef:57b9
 with SMTP id 98e67ed59e1d1-35622ef5e30mr1233745a91.3.1770505643077; Sat, 07
 Feb 2026 15:07:23 -0800 (PST)
Date: Sat,  7 Feb 2026 23:07:09 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207230720.2542943-1-kuniyu@google.com>
Subject: [PATCH v1 bpf 0/2] bpf: Reject access to unix_sk(sk)->{peer,listener}.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Accessing unix_sk(sk)->{peer,listener} is only safe under
unix_state_lock().

There are many functions where bpf prog can access the fields
locklessly via fentry/fexit or bpf iter.

unix_sk(sk)->{peer,listener} could go away during such lockless
access by bpf.

This seires marks the fields with PTR_UNTRUSTED to prevent
such use-after-free.


Kuniyuki Iwashima (2):
  bpf: Reject access to unix_sk(sk)->peer.
  bpf: Reject access to unix_sk(sk)->listener.

 kernel/bpf/verifier.c                         | 19 +++++++
 .../selftests/bpf/progs/verifier_sock.c       | 49 +++++++++++++++++++
 2 files changed, 68 insertions(+)

-- 
2.53.0.rc2.204.g2597b5adb4-goog

