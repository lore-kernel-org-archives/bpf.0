Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749339;
	b=qNZhtHUKBAYzSImNHw7DjoCI5ln+M/nr6NN8P2rMM3lMXA74G20ufYEFYG0bLcS+IrhA
	 orqVX6VnvuttP/A3CAZfd5/DjTNQEpkxAFT9iI4Z7c1/8ng9MpmWWpPzNT7xszU0Kwqtk
	 RglTlJUa41Bg4bTKa3diulAYYE7gU1zegXXFO4Sc+nPiHXM/5YgE5C1xbfI3GzdPgfhkO
	 Jmocd5U8+i49baLF2JDWXx/a9A7ZpyLK469cvxqM0wbIh6bwE/U8TlCkTOlKeNGn6xD3P
	 OeT7vOAzccBwSw9F5a+Ptp0Vc60bEwtu/iI+dkxgDvGpYzWuQkO/PgP+Drfvo9qi4bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NkxImkMlEn4tle3ovG9KwB+QIKm3ruKix/vODZKXxCs=;
	b=S1CvYzSzB9Dp+33MqCuWl9UUAYhUzOXh2vDgOTOxd9ScXGyt5ziUKJTNUrV44cQcCPfz
	 nwsOvH/cun+BxCa7GG9M9YfvbXHOO4R81JTrX8cvOfjUKCEB0/d+rpXKX4eJ/bI3FmDCL
	 kCfAdGiXt6a/PtwTDsJQOi+wJucelFRFvdcoPiexGVFLadUTbtdtVPTm6DWi1usQimr4V
	 8exOF98R5d5EQVPlW8FYIoBNHss1PpH/p5bBH3WgpU+SH/jTKbWpBm7JcAUpaAZVeHi4H
	 iwA2QICo4DKnKfFjeew7TdfxbsR9QQzIqgozic2jhZ+vLVIzq9n+VWsd9W26DfXulSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VMz5yqva;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4B8606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF4B8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VMz5yqva
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso525895ad.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749338; x=1794354138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NkxImkMlEn4tle3ovG9KwB+QIKm3ruKix/vODZKXxCs=;
        b=VMz5yqvap8tPwZ2jfMkHoMfqHAiNsOzpAO0q5XyYIcWw75s2D3TbMhfv22N4l3sn5c
         sgDGOqfikqNfUQ8W753Q01VvE908XueOTOb1ecp/OnU7G8hHeXhGN7p3RU2iGoCBrm8d
         t5vgid6Weqd1uUvvT/wLyOvX6bweaEk3o6SS4d4u/UBddxbYfboozzCOZNRyzhazW8Y5
         sNC3ooi5t7raEQvVlQiy1K6njmwOnx9l2kUrFTRMNlnNTE/rgYXWF+ApCLpcTbOXWbyK
         Yo/dqFQXFyX/UCT/fP2YAZ2fQfuWJlkEshg6BZO+BkJw6P1+kDUA0/zZ/xJIHrA8Myy6
         W3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749338; x=1794354138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NkxImkMlEn4tle3ovG9KwB+QIKm3ruKix/vODZKXxCs=;
        b=G24/xhL3oyCoA3OUgvwoRYyOu+t7UcmJ3Rkc3jo3l1xZfHK7s4TEdyhe5g+Xt7nUBh
         M6tCcoHMgmQDp/R8Iov9h3oXZBGTM+TkX4ovsI7GFwz/2jWxYn9XNBoOGSjjEvPuoSVy
         iIl6WyPPfbXe2dQPxWzBwH1B8000OIWoh0GWbCN9YpCVFJQL/f3l56OV1rEwTzZg7oCv
         nsOtTjFpqa3qsfuPCQJSgw2ziiISx3cg47BFChxyHuyOLTV07pFFRazKJcrd7QcHXDs2
         7Q7cFr4dwyHs3NpafRrjf/CeG1obIM4nsDsD1e9yWs+c64q3PejR4Kb//ndtPL74fA56
         x0Hg==
X-Gm-Message-State: APuU4Z/MsIzf+xFmRRzMewXmYUvJX5XtLV338KKTdT6x/qa7Kdn6xhAW
	9XiSj1VHmsY1oiapHmLINahOMkVdMbNyuReUEGTT/wwyd8NIxikqTtTsHXehkQ==
X-Gm-Gg: AYBFou3nMMFXMC69HaybKjwhTe9wOIFMr5V2E4owVvP6rYvFFKoyBS1ZUwsEoHoaJTn
	IwZ2OPELF9MkxryIUZVWgEtOl0ltrA/YLm9+lqxmhAdNcmnNb8rWCYPAfbY5j7ttmL8IgSq29wA
	9fB695M5aams28wVcf/cdbhU3K3I7Wo27DwNV/7v8bxEv6BpXPZW6g8Hg89PihnTGPlYMKCX1sQ
	gt83sJCAR7GHVjkEnjy9nLAR3yt/6vYbS/r/bqp5kNftlsWZPhSZwv/EXGmGcK6vVdG1LBmdhy5
	3Jlu5jzeLpGIYVDzfc7u43PLkulnQy/GzNsXbSlMs0pn0uM5Ao+iv5Qho/qKGlDvfKuc08Ob+cp
	PDhwUI6K/zdGOZJOFqURm0lYSZp+UQZRax4San8wqnocZDT0S4v2TZ1612Oq60AD8+LNk4Dl2/M
	eV8MWDaG0kRTEA6CR70JkjtqMMLyPD7kcrQBpvq/hu2XojOx/9sKq0aH50EjEKqP+q8GarIfmqd
	PFmA9p0tKYnowu4B2cFS/uFCOaGIhYyMS+Tb4Wj2w70nxTJYl3RBz72NwKQVXXgtC1D71XVeF8u
	GDkT/YzpQp4MhkV1S53LJO7rpkzlZOKOjXDn22sKjAUsALvIve8Kncnx3rgmmpMyjxbacDUXHcU
	euB/aif5Qkp8iYasSk8PQz83er6JKmXwzJnnvdLiXojW0oUnY/smpkw0V1R7YKWQO4EB+Q3ze0A
	==
X-Received: by 2002:a17:903:3847:b0:2e5:cf33:80bf with SMTP id d9443c01a7336-2eb364f6571mr155379965ad.56.1793749337934;
        Tue, 03 Nov 2026 15:42:17 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed090a1475sm409545ad.41.2026.11.03.15.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:42:17 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 12/37] bpf: Helpers don't write through ARG_ANYTHING
Date: Tue,  3 Nov 2026 23:40:37 +0000
Message-ID: <20261103234104.208239-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

A loop can keep its counter in a stack slot. Scalar evolution calculates
how many times such a loop runs only if no insn in the loop can write to
the slot through a pointer. For a call of a helper,
bpf_helper_stack_access_bytes() tells what the helper does through each
argument. For an argument type that it does not list, it assumes a read and
a write of any size. ARG_ANYTHING is such a type.

strobemeta_nounroll1 calls bpf_probe_read_user_str() in a loop. r3 is the
address to read from, and its type is ARG_ANYTHING. The liveness analysis
cannot tell if r3 points to the stack. Thus it assumes that the call can
write to all stack slots. One of them is the counter of the outer loop:

  loop header at 244, can't compute iterations count

ARG_ANYTHING is a number that the prog selects freely. check_func_arg()
does not examine it, and the main pass keeps what it knows about the stack
over the call. Scalar evolution does not have to assume more.

Clear may_write for ARG_ANYTHING. Only scalar evolution uses may_write.
Keep may_read, because bpf_probe_read_kernel() can read the slot.

  loop header at 244, header_count is 13

The outer loops of strobemeta_nounroll1, strobemeta_nounroll2 and
strobemeta_subprogs get a count. Each of them changes one more register
that has no formula, thus the verifier still unrolls them.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b480c5c242af..06e72aaf6769 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15104,6 +15104,14 @@ bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *ins
 		 * analyzed separately.
 		 */
 		return (struct arg_access_info) {};
+	case ARG_ANYTHING:
+		/*
+		 * A number that the program is free to choose. bpf_probe_read_kernel() and
+		 * the like may read what it points to. check_func_arg() does not look at
+		 * the number: do_check() keeps what it knows about the stack over the call.
+		 */
+		info.may_write = false;
+		return info;
 	default:
 		return info;
 	}
-- 
2.55.0

