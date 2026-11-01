Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560947;
	b=nTsAAY0KxgPaRCFArl9EvkhIiH/ZHZCO3tE08V8fmYKWPpTS7l0uS+YUDBzDKlLIOxdo
	 TWBlkDyAXyAxfqF1jgqZxJlMYfsBN2ZPIvxpYnGGFVSuw+ruF1/F1qN/L5MF2zYIMMpiO
	 VKeNnIw/1e0sQtpKM73b4dqGoGrwcBHbOETkBbFDzQm3FXGtNEl2Wh42mCOPJD9kclMWF
	 WJ02deu5kTQy/4xB9x/Au3r35RnJ5hXy7QwunNRvn0qhePv78+iuNmUCjHnlGso/+lGRG
	 hXJdJeXR59RYQfmpkhnRKYJCC9W0mPobzvB7djjDQ2rCNX7XmgBU2FJvhM2mgEFoT9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pLfQTSZWiMHhpz6dJ4D5IaCGs2afSNTfy0DFwwVYQDQ=;
	b=qbfLm3bfBuDVkshF54ZL6MkQu8zfmp9NOk67r2ELTTmXxge6XlMzSepm8e64pVxhO5iE
	 vu0yAfe55prZwxbbwmEOgslzIxE3sQPmP5u4ncBg5gQNphLEIH2eACsJjGMoyMiUUZvKb
	 Yyo946LxrNfj7e7RvygaYyhDryBr8QQvpo67j0AGStSYNLhTa43TgA4fBfQVDbbvZMV/P
	 vC7feHYX9CpWs8CMCMaeNhJDRepG9PcZEWNZaCjZ9Oz5k+OeQOPKibtsFn4194Jr4zTJL
	 hO3l+TpqWVrA5zQWlpv9brI6l8WFlcDAl/hq2jIEkVK8U2oZmu+jPZhnS/6iWaJf2Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BRV4wo01;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110960A2615
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D110960A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BRV4wo01
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso714289a12.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560946; x=1794165746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLfQTSZWiMHhpz6dJ4D5IaCGs2afSNTfy0DFwwVYQDQ=;
        b=BRV4wo01yuPFeYbBbTQCbaWIrRZKl+tkEOKn3HueFgegwxzYyUJpokh7V/ty+XSNi0
         Cu6cVLukL+5q3juZ75cSK2YmlzkDGk2q0yFRho0uOICgHqqNsb5e5HU7QGxh9WJfotHX
         HjTMLjDKlqIwf7mOyvk7v4mu30Q9r+zt31M/8pFjFmV2771C1E9m3706YKEs/HbIg5ap
         07eEM9xZay5cuyxrldb6m8Mjzebk3uFp7hSqEePzoTEY8eba1RBTFedSuo7ca5NbWUFP
         nOEsPwpBoejX8urHDVHXsHRDyAY1mKyUvdxwdKY9LTLCwfLUqSofql9ATbql+l5zfLzs
         JfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560946; x=1794165746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pLfQTSZWiMHhpz6dJ4D5IaCGs2afSNTfy0DFwwVYQDQ=;
        b=Og6h6A/EI88i4H6ezKxOOKPceC+PTMPqrtsJ4PtmzF9FKfy1xqaXB7t7NTBhc8kkPf
         v8pPeyYVejn7k2hqfOI8sbAOHvKpiiQj5ZlgibKoZzB4adNqWfoE4SoHpI0yLpZkqFcf
         jmciAcEoQqoRf4y2Nvzne/RMqwbxcGDKythGfywwBmkjl5/fow8y0ocX0TV5CqrqxT1l
         DBkWQ1zJcZvAVmQw1lFFnDxUXno1OH8YigkMuIAWXtvNKtYmJfQM1loGiiLiWsAQlLv7
         uKMZOsLJLXrXTNVqTBX0sPg8WZyBLqZrVld5334spuxzV9Diy5VkX43FEzw6Ru7q00P3
         0URA==
X-Gm-Message-State: APuU4Z/J7UEOocv4XA0s2UsiDLVHuFUAFf++7pmgZtO1/TTIW6nLm9SO
	htNWLN6mmY6y6MtFKQSYTwJptT8OLdUxM7/dWTZtjKmtNjI7ZBN8HdiRs8v8mw==
X-Gm-Gg: AYBFou21CqR59FNbC4bt83n14aE4oUbJpJo57TKO9n9kKnLLaPdNg82lwBd5ftmgkXD
	m+cXQ+AdfQSn3Ptt5ILi3ttdl/ebl8t7tqQQvKeGdlvkhIEYgRSqX3U0WxTq7mKYtYTJG4cISQZ
	brZ8SzXvOAKgKnf/F+j8MG4+GV+ZP5AyCzgjzBOzdkxmGOESHfsdsiwG0ESXW9Ce+QNg9JbukZJ
	4et+nqpAU6lEItH2nx0KT6DkkQSejm773kU591GmTP72Ji6vpfdl7VL76PqKA+wlAtqtCtSF4Yv
	CwmXJfph7wRmo4W6jtu8x1IjnXTAJIqtAKC5VlTfOgyVdSDLiMUPSRc3cdshzBvthdRpwgpcZmI
	jS+Y+vTqTkinG0eb8ruNYxz/LmEtUoQIdkzJEBmslNABCs3ta2aDsbTOSdQ2wRINIZ4fTWoyMtk
	AD49hsreqwoVsqhia1DgpO+MgsWkED96ucvHLDTIPTDPfsZn39UYVCiSoOCa4g9/E8hIUDDzSpu
	t8f7Fo6C2VpB0HZ2dqIVglh0Nm9c7tyDa4iUpynkPg5TDg3k86tzIxTvyhcuZTPOHvwE+0fFwWh
	44HyXgIB3KM6OJa/UNlYH40Xh2ctaUGQfkJ2Lk6mfXnvFZ0aQmyhf6nkOveCgLJZSsmI2GJtVsI
	tFTfEFZphavddvPAKlspx8Ysn252k1+Z7d//KsOJ2kFlX6B17nidc5RNlqVlC6LDYrvmcYc48uw
	==
X-Received: by 2002:a17:90b:44:b0:3a4:acde:1e3b with SMTP id 98e67ed59e1d1-3ae896f8546mr7005266a91.13.1793560946060;
        Sun, 01 Nov 2026 11:22:26 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e973ac6sm16068213a91.11.2026.11.01.11.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:25 -0800 (PST)
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
Subject: [PATCH bpf 14/15] bpf, sockmap: Keep the rest of the cork after a redirect
Date: Sun,  1 Nov 2026 19:20:56 +0000
Message-ID: <20261101192057.2296489-15-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

After bpf_msg_apply_bytes() a verdict can apply to a part of the message.
Then tcp_bpf_send_verdict() sends this part and goes to more_data, and the
sk_msg prog runs on the rest. The SK_REDIRECT branch does not go there if
the message is the cork. It removes the cork from the psock before it
releases the socket lock. After the redirect it frees the cork together
with the rest. Thus the rest is lost, and sendmsg() reports it as sent.

If bytes remain after the redirect, put the cork back into the psock. Then
the prog runs on the rest, as after SK_PASS. If the new verdict is SK_DROP
or the push fails, sendmsg() now returns a smaller value or the error.

msg->cork_bytes keeps its value, thus the rest can stay in the cork. If the
psock has a new cork after lock_sock(), the kernel still frees the rest. If
the redirect of a cork fails, sendmsg() still returns success and frees it.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 9bdcbb0a5998..a9af6be2aadb 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -536,6 +536,14 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			if (!cork)
 				*copied -= free;
 		}
+		/*
+		 * The verdict was for tosend bytes. The rest goes back, unless
+		 * another thread made a new cork while the lock was released.
+		 */
+		if (cork && msg->sg.size && !psock->cork) {
+			psock->cork = msg;
+			cork = false;
+		}
 		if (cork) {
 			sk_msg_free(sk, msg);
 			kfree(msg);
-- 
2.55.0

