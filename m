Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228DA30F540
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881156; cv=none; b=QRzZLVpGoKnVlGfkK7Y30sy5bC9n2KMUQI4fWdWLIunQl5uif7bMKumY0R+w0bL59sqAGy5YFghTF/2l/J/PNNSoAqCqBWJEpvKQvggGorNZNziUR7/Fl7k4zfs0t3haWWWdZwpx8iGx2ymF0TQCv1/xZAKlM3aD7ig8xyg5fcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881156; c=relaxed/simple;
	bh=grBs00BfR7Dgf7lDiyN5qgf6vPiH1ATGim4nShDBzQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Up7hhsRytcQnzM49nPyF9eXknU6GCJFolvd+HZNSkDDfdaKi+q3iivil+JdQnIAM0OCUjXANa4ZKEa9H220Vy9Aw9zgHojkugf88P4hHj/D4yAh36tkf+6ZtvmFC7tui4qpfZGTYabi9fFVpMsrphTn25GvCcNc9/EuX2SNH1kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ic7VGKcz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ic7VGKcz"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so1638109a12.3
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 00:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777881154; x=1778485954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFTHSBhHCs776VEULE7S1mvel/jKgBzCStXoNW54Izk=;
        b=ic7VGKczrIqcuNLPtCx68pTMEgR4yjD5v/A9NZ1Ye8cCNC3X3y2pM14cMki3NXRb7M
         sCROtTghtPJWp/0tGb66EdR0j9k/I+v1vHpphqPtucMYBf35099yZp4I3S5P9k6CDnW2
         c8rasKbDB8vbbxAzCENeB9YtdVM9fQaq9wYFx3lZ/NMlyZ5eqJXFcyztuQvc8RbOpKBF
         AvOO50Loq+aY+8/pN5jxxXbILLRCiEii21GKb8IKaywZuG0uufiHPFMzdHQgW/8pQyk9
         UwEVj3BErWOlcb1g6Wlu+28ftpK75tP5zTZqgPY+AjiVpY7lQ197UCEt1lcvdND6Qu/o
         UfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881154; x=1778485954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFTHSBhHCs776VEULE7S1mvel/jKgBzCStXoNW54Izk=;
        b=aEN9GXTeHEK46RP7opWcd9r8nWuE8Ka5NkgmR6dOnE7Y0JqRpufUlWAU4IdKVaY37W
         DKv2KR3xdS++feaHYHrgVnSqxOdjWy3ytpeRve2+Zuo57H7rIlspkFfbvU96wXrTAhAx
         cMUHu6DCQGtU6UONa/ICwUqcaPlf7uJravQJ0b6qHUSqYbS5wxaFSfu4Vi+j1YnXsCot
         9E5O28zqqaunNELuKUtHLbbwGKhPu/8w8kLww8IiSLjKEg/6M2xdKwT/Xg8tuuyKQ8B5
         xWxtiR9b6KrqKJexLQHu1l17buefSvmSOUplnSsCvWvODiDFT6QIpCrAKUBw9rPIDJh9
         0sLQ==
X-Gm-Message-State: AOJu0Yxeymr+36GY6l38I4gb+BMqBs8v24NR94y++CIUm/z+81D7nOfA
	KA3gkZUkkajBK/CkiTBsrOCMRrXh3vb0Iw0ZzpJa9QIFJxa6bmQWF7vbsZKUF0VDLf7IBEt4Egu
	fHkV7oQ==
X-Received: from pgbbe4.prod.google.com ([2002:a65:6e44:0:b0:c82:26d4:bb49])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8a:b0:3a2:e59a:7a46
 with SMTP id adf61e73a8af0-3a7f1ad06f8mr8848982637.24.1777881154263; Mon, 04
 May 2026 00:52:34 -0700 (PDT)
Date: Mon,  4 May 2026 07:52:19 +0000
In-Reply-To: <20260504072325.23474-1-eulgyukim@snu.ac.kr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504072325.23474-1-eulgyukim@snu.ac.kr>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504075232.3861715-1-kuniyu@google.com>
Subject: Re: [BUG] KASAN: slab-use-after-free in __sk_msg_recvmsg
From: Kuniyuki Iwashima <kuniyu@google.com>
To: eulgyukim@snu.ac.kr
Cc: bpf@vger.kernel.org, byoungyoung@snu.ac.kr, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, jakub@cloudflare.com, 
	jjy600901@snu.ac.kr, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

From: Eulgyu Kim <eulgyukim@snu.ac.kr>
Date: Mon,  4 May 2026 16:23:25 +0900
> Hello,
> 
> We encountered a "KASAN: slab-use-after-free in __sk_msg_recvmsg"
> on kernel version v7.1.0-rc1.
> 
> As this issue was identified via fuzzing and we have limited background,
> we find it challenging to identify the exact root cause or propose a correct fix.
> Therefore, please consider the following analysis as a best-effort guess,
> which may still be incomplete or incorrect.
> 
> The issue is that sk_psock_peek_msg() only protects the list lookup; after it
> drops ingress_lock, the returned sk_msg can be concurrently consumed and freed
> by another recvmsg caller.
> 
> Following is the harmful sequence:
> 
> 1. Thread A calls recvmmsg() on the socket and reaches __sk_msg_recvmsg()
> through udp_bpf_recvmsg() -> sk_msg_recvmsg() -> __sk_msg_recvmsg().
> 
> 2. __sk_msg_recvmsg() calls sk_psock_peek_msg() and obtains msg_rx, the
> first struct sk_msg on psock->ingress_msg. The ingress_lock is dropped
> immediately after the peek.
> 
> 3. Thread A copies data to userspace and still holds local pointers to
> msg_rx and sge = sk_msg_elem(msg_rx, i), but has not yet updated
> sge->offset/sge->length or dequeued the message.
> 
> 4. Thread B concurrently calls recvmmsg() on the same socket.
> 
> 5. Because udp_bpf_recvmsg() does not hold a per-socket receive lock,

This reminds me that I forgot to respin this series.
https://lore.kernel.org/bpf/20260221233234.3814768-1-kuniyu@google.com/

I'll rebase and respin it.
