Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560868;
	b=z7UoBEz15OEs8zKqNHodvrodiBpbzMmJ3gx3i9DZDApyIT56te3cVzBC+agMYk1ZC1+l
	 dFLzWKlA9tEtdH6s/g7CMiUIkXcdnfu1WlU27ELE9vh3YX2ppF0JEl9VID5cXEknJ48hj
	 LXfeukZ7kCHrezj4DMqmIH3/pMhZL97EyHJXPmYH2AEuGGKFROBiGa8xFdu8khNnxa4uK
	 zuRaBMECdNMs/KqfRLzUPLhhVfzFwsXYTdwR34O3HQxoKK4H0uy88mdH533yMj1MAhY6e
	 wFtr56eoVgZgAyFffN4axfC3kUdZ1rVcbyd6k7DquLIpP7ICkqBydVzwuR3xQPXxkqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
	b=ggAyzw65ioSA/dqsxnQCPN+5Uz6YDHyTkBM5jw8yO7Z3WnvcxUpMId/sEOR+zRr7GLUr
	 GM797RFXJsOMyoa2WzJ7ot84OUBfP0nCxxLSwwNzGV/1rLddYFqE3I1Fm2hnaIFKvplSL
	 l+asNeDlogA164Z7L5yb7xxKt5358yw22+iFD4uWDU7jpme6aslu9ibpSZB859GZBiw10
	 C4f+AqoY2gJjss7W266d1+/ST5lTatRoEeT3MIFEFsX2iqNSMNM88gmfLBE4OuDix2suD
	 jrNRZ6xrxUWL/yHNa0NZj5+/c/A+Xt/eX9AJLqp2vU8pPFBwF04vIvqkPUBh0Pgf8Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pIdlpv23;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3946606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3946606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pIdlpv23
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc502d509c0so782064a12.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560867; x=1794165667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
        b=pIdlpv23hyRj6iU5yvB/XBxl0TyThVnfXGRcF6Uk+rZpVLTrnbHJ/7S1F+bdMKtXpA
         s45sf0lR3YCcSgBvvRagmuywyiCVDe3wGB1UdWZ1FF+P5Kr6MrTDHAY4wvUHxCZl1hg6
         xvk4H5yxlQXFfaAbDD6l8ElgOcsEp4LnwacxLtJ4azwMfCu6bpOYUMfxlD20nriToNkQ
         5C0p9TbQYNvRxDDuTEO+vMVvTS7yvQ7ZTDLY/inL7IiTwn48rKej/IW3PWuR25H8qwqM
         KND5NOhRIZ2+RXl505R+CAkVMpsDwSMadxziOfz14CHIkfbXrpauPKhWhzzVa3CFvL2C
         OeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560867; x=1794165667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
        b=LJtHgq9aUerpt5M2kwquFzIV0QzwbGPQ1r3zYYXR7/sld7DsoG9w/Y7tgXzl9Qs5S9
         ITFLcKwi41ym38XuldymSYjPaqjCja1zvTmcgC0EHlQvpGV2GOWMl+R06g+6S6RWZIXp
         cvSxetIFUn2ggob6PSHGrkc9khz/svuK4JBWM5mMxE4z7xlxZ2StR7MxSaiRHeFFIq4D
         3ui8YyNDojHDw4WyFnZL6/yFBU0SKxapr56X8/GH/3Bv7uMrjEoRAWhg1AV3B8w+1Awl
         vzNtCvtTluQJp29yYT73GXMiAv73dBHopYxJVZAmW1uuyzw5OE/7cEHFVr0ZkDV1DCF7
         DiHQ==
X-Gm-Message-State: APuU4Z+Wfd4lnEfbqX886/KglBqaJcUItxEnD9NpWZmx/gDGoXjIRrwL
	bWKkLGsVnnHENi9q1ev5pSWuj2qAkDGpj9byk4ecpH15jNylkkBwtj//vsrMPQ==
X-Gm-Gg: AYBFou0QKiR9kyCiEWtuYUtYTMbI9IAr3CpQaa6NS0BnEqkrLPFFjJ6V55kyd4SwAw8
	5NOjJ7LidrjLD0cNt1ERTZrwjFRZlrALQqk3Bf0/iCqBuXv2EVElVFQiG4msUFUKp/P8Kr1ZV8V
	jbAxWQ4uZGg6UktPr9ZYPFTZsFoJzsXvBYAPC6DI0Nare2ZmZ7Nec+oskKVApFZnhNG9lAdcL1p
	6Lu9dqBPx/6RM4WqG/twFNk3HaqR0IQ6ua8wRv/7XzYBYMVqIKVBaOph6sGvNgxpiRltxMWg51z
	ejlW/1dK0ew5Mc/ZmtFV04LvtobPcT5Go3sBvlstS5xK6vJ6b9BNvHZQSLwp3aDJHg8T5fNmpEi
	ethMhlkqRy2AcfyTDA7WMsjewzDckwcN48+0o/mSHfCEkK0VjGls5xWc16xLxPz/mC8TsTdyBON
	sngkQ9fmVAaQCjJFbKhEo3APifsTL6iDyOdjsiYaT+1ENcpC1beuZ2RgOoOSMxPpTjJ0BhtwToS
	FbqgFNbnVD0ouDSfLMlZVf9rXsKQ48BhbSsKevzvw0ixX3Zzzsyc1ZirpbkoaNQXg1kwZKIfUxK
	hvkQvyNlpXyn4c+5P3upenCwKN/sezNcmtBFtZc17e2RmJ3e8eLPd4YAE10bPl+6pVi2UBVQ+wx
	/8LVWtjXICg6qua0zZC3/9SUIE9BA8/d4NgooV1wgDM4azgkIDjdEO7e3g0+COlPJxbix49Cpzg
	==
X-Received: by 2002:a17:90b:28c7:b0:3a0:a912:e759 with SMTP id 98e67ed59e1d1-3ae897ee62amr6770112a91.25.1793560866933;
        Sun, 01 Nov 2026 11:21:06 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845984absm11157931a91.10.2026.11.01.11.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:06 -0800 (PST)
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
Subject: [PATCH bpf 01/15] bpf, sockmap: Write sg.start when recvmsg() faults
Date: Sun,  1 Nov 2026 19:20:43 +0000
Message-ID: <20261101192057.2296489-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
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

__sk_msg_recvmsg() copies an sk_msg to the user buffer and starts at
sg.start. After a full copy of an element it calls put_page(), unless an
skb owns the page. It handles 0 copied bytes as a fault. It writes the new
sg.start after the loop, but not when copy_page_to_iter() faults.

  element    0: length 0, put_page()   1: fault here   2: not copied
  sg.start   ^ today                   ^ this patch

Each subsequent call copies 0 bytes from element 0 and returns -EFAULT. The
user cannot read the rest of the data. sk_msg_free() starts at sg.start
too. It calls put_page() for element 0 again and can free a page in use.

Write sg.start in the fault path too. The commit in the Fixes tag removed
this write. Do not write it for MSG_PEEK, which changes no element.

Fixes: c9c89dcd872e ("bpf, sockmap: Fix partial copy_page_to_iter so progress can still be made")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index df385a5a961e..f03519468ad1 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -443,6 +443,9 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg
 			if (copy)
 				copy = copy_page_to_iter(page, sge->offset, copy, iter);
 			if (!copy) {
+				/* The elements in front of i are used up */
+				if (!peek)
+					msg_rx->sg.start = i;
 				copied = copied ? copied : -EFAULT;
 				goto out;
 			}
-- 
2.55.0

