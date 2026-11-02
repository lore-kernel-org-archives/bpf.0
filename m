Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604091;
	b=VnvdIGXjhglVxTCt+/2vr6eodm+vR/9BNM+Jlwf2tyqjZKOgPcvsfwINkz2rmGpfycZA
	 AC4rEyC7eaMIUdmyQu4q1f2JGNdrkvOFFgKgvqEcOzBoOoS+zSnLjcKxDegfN/cBG/cj2
	 Lh5T4Ckje1IrFhs6/jxZLK056F7Tex/evUlrnHgsm/XJtvx4jId8WbBrXONm2X1Fs33iM
	 nExRX1C0vItR8VNuHixcKs1/s0iwTnBm5fNJZtpfKqi+bv14HpRE5+mYmLQvhEXLKMg6J
	 v6H8Sc8ptwzb1VMk8q/alIjEbXYg1WCdsp9WwLrU3zMVvFK7PE7NMA/lhwuqVtOqozA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
	b=RJClUjA/jO2nGrrPJ4gegJQuL+3pRJdrRq92Mk3F7UECMjbSJKW1nHX0f4PoPmec+313
	 VzuJqrjACJyx1VSwz+3rLKowpvj73+wKgPDsfVB5yH31CoYQFKRsV3p0/prDaogdneEcv
	 mQCR138ph7rq2k0JqrQwe+c4mgXKCGVK70iQKsFciqKdmbLIs0PFbV6Eda2M46cpJw1Ev
	 FAl0RX7wEVzF1t96biwPRZrsm+gBonAXsEU31UWYCiIimKlwQq5wLcGYA/aJYIqo34MxU
	 8VAM0dsWYS/ZwMQWNee9HpfANKey794EjKhL8LQVMQHyIOvxfJ2mxu6unH5A9CXvl4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HiBvqIK3;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECB8606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BECB8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HiBvqIK3
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso1115368a91.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604090; x=1794208890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
        b=HiBvqIK3Zg4oQgilDh0mFc4euQ5jy/ea3q8Q1UMieO305xm2B9TfDL5rHhuPUtPsns
         HMX3n3uYUrRd8TchZ4moNiCCrtqPFvwfnhbkg8rBNi560+OEcapv7/cM0y1E9vIHjfSm
         xZ/ODBvPNEvQYWOBJ+UtuuxgpRS/uV6qO7w3+UHHH3laYLuZAP+PXNpqo2E8EwYWHGrH
         ebr7vDxhIfYFo04TMsM73qDN5RX8D9sDURjtKFYwrURUlHumaL9r+u74Y48o68KYr8IF
         JJp+ZtK4nIadae9myAdsFSbz2nzcWJyJy39/8XocOmEzbKbdpY3ObsW0Km0TgKe91w39
         8D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604090; x=1794208890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
        b=xyH9hDski2wR/7JXQjIzaRtyJ9Jtim+0q8r8K6STl7r7Dqkmg1iAl3uISDQnmhwV+C
         FvoQY58OMxMPb9FXGzV4snkHwNWZLeGrNPdN4nre1iV8VXWSqkfXG19beu3t6DyLOmSZ
         ILX46OKcB2sI577MfC5grRzki7bRdkZCJTdBI399/M3zRv7Ewt6Sp5rr4VKUk8VYaGlO
         2A+LqhKlUhKuuYJFROruoALCtMHYXY0Qg0sNGYxWZYv2nNuBasWy0/Uuu/JPcFhTbUF9
         +Y7JC23cES9bilKRNmECQPWV+BnJBfZUX8sgxiALbddV3VRfcqas6+pbalG5C1nVcYDt
         aItw==
X-Gm-Message-State: APuU4Z+apEsnPMS32rk1XR7ToPtFMqoVDVUcIpVr/NQ4n63hJTEAkBg0
	RlSLn00mtkUdw5LRMlaNwyLF/sopOjAB9oY0GNHtNlFfXWyXkT/PaEEl/onYZQ==
X-Gm-Gg: AYBFou2njA1vCdb+GVqNoIZuv4QU0p41cxf+OCHmkcJJlZcNqa1Bba4Ryo83+/MRAgM
	8F9V1HMbiFpW68bYt/lTYjORgnOLOFWM/Ad7anjlYUq+aa1OYGDvHNiCZ1agQBHTO3SWSbA0HOj
	iAgNbvv9AgyhS8ndK24bo6hGt+/+i8yc7zwpaV/oaCHJKPQKLjewjkLsVRMh7n7tzeR71vBETWT
	I20uPyEvgUNzmXRlJKAFoZPRPLmNdOF+jKBcURD/9N1b5UiNdSa/znIGBXBWFAchV05keItk44Y
	OhSqyFX09czhKwzQ591GilcWdDIHnNlv5jWg7UmJapP5KUFsehkAhDjOnSCWuZ4D22yBV/81+hM
	yOEb7yL/ADW9aimKTIdTbCdsRF9qhYtAiiirU3o/xFcR1lxYMSK6IuqRPG441DhAPnxSgjU8upN
	8mdKuHYWusY6naWZoxfwMD3/qGOKIpdPw2mir+ck/H+HO5sa3g9B+/myzWLN+HX5bdNFEYu2+F3
	ttLPHFVoX5WU2YUF1EJVEFkjhSu1j++PzYricy57Jf40Hyr7LgJ5u5A5AONYIAXbgcRB7V7xOf0
	cIzpbCirWVIflIZwbZ8qI5K924u5uvH2i76Nect4fmV2o7YVqG1Ys+i37tT/r1mMSQ+6J93y+VR
	gW9Bqn8nR46x4q3OdJUjXRp2oCAeaauna7iM34s5b6pEjJ7l2H/bDDIYr6NlLtIMKw6vn1NneIX
	Yv
X-Received: by 2002:a17:90b:4b8a:b0:3ac:1c76:61c3 with SMTP id 98e67ed59e1d1-3ae8974656dmr6955366a91.27.1793604090070;
        Sun, 01 Nov 2026 23:21:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d5b8csm18000578a91.1.2026.11.01.23.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 02/15] bpf, sockmap: Don't let an SK_DROP verdict stick
Date: Mon,  2 Nov 2026 07:20:59 +0000
Message-ID: <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The verdict of an sk_msg prog is valid for one message, or for the bytes
that bpf_msg_apply_bytes() requests. These bytes can come from many
sendmsg() calls. Thus tcp_bpf_send_verdict() keeps the verdict in
psock->eval and runs the prog only when psock->eval is __SK_NONE. The code
that resets psock->eval is after the switch statement, but the __SK_DROP
branch returns before that code. Then sendmsg() drops all subsequent
messages with -EACCES and does not run the prog.

Reset psock->eval when apply_bytes is 0, as the __SK_REDIRECT branch does.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8cf63a9e7fed..d90bcc911b36 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -509,6 +509,9 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 	default:
 		sk_msg_free(sk, msg);
 		sk_msg_apply_bytes(psock, tosend);
+		/* The verdict holds for apply_bytes, not for ever */
+		if (!psock->apply_bytes)
+			psock->eval = __SK_NONE;
 		*copied -= (tosend + delta);
 		return -EACCES;
 	}
-- 
2.55.0

