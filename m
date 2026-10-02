Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB849315D5D
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933120; cv=none; b=fOL6lD1Uh0NFCi92mjF4SO9UsM78pql3qsxwR4PVOpRpW9DZICMzXDhsFdU/nTUl0T4rf73j5ZaKykSdVgJpZF9hQ/KkVleHJH3ZrdhkjC6o6qUuyqpo8aJP6VRTIKxGV8L8ylCWKd4gKHG2hldwJTemH9WoliY2CFJnYN0+aMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933120; c=relaxed/simple;
	bh=m28MzYzyFKktEcB4BJwAluU1oB/N4PQmOwOyp2p7UFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuxgMsjVeRzVKAkwsq9DynDwr9/WKblOZRnEl0bBdDxxmk3qYbYJr2Ej+OL+Y/42F/bnocHH1c+jIexlKjfzkF/FZW1Kdyqy12cN282ydRcKL5pVI7lSC/fUhjcYZOyeqs69yXw1c8GIc3/rHSRkE3BYmRNy0k/uO4b8YxRKOAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=S2Y9t35W; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="S2Y9t35W"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91786d375bbso33872616d6.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 02:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790933118; x=1791537918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SkCLCctHQ2Zc9DbTnJXFu+fhyojDPXTxcOonrclehQE=;
        b=S2Y9t35WrFhbP6/ZThscq1QlxMoBimEIYlxmL75KlwUgQA71HtI4hfkO4a5MuG8JaU
         LqF5oo9kLTvweaQzp8MxrvD6pl1xeQJOea9BKa+0zVdt5xkn8QhFl0y9wZXU6nla2/tR
         SFSuo+AV8KJZsFCVPcrYFNNV5XEXxeetfw+kL7jaoLLE7Ojzt637ps0Rc0JRm6F6rW8j
         lt3Hw+P3eC61kt9wbiYWrzCbSmpjYDdccvnocAFlCH+WAO1QAvG4+Ao42uf/Mt3EhUnX
         DqI9bDPIlEB04u1PbOTuYg4xqfeWrh33thefXz8WdVPCtGmedbBP0rGK0RplLMSXqq6n
         NWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790933118; x=1791537918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SkCLCctHQ2Zc9DbTnJXFu+fhyojDPXTxcOonrclehQE=;
        b=zY8t5gFXglVwauVXTn0pGVr4Y8bajvc5DM4qiKTunHQeGeo5t8uviweJUcVj2Ig8zv
         iJFzmtA0aj/3d9OKJTcGoCcHuXd0OV6O8Ln3/RCbPei6az0nenHyOeSdJaCfk+yK27GB
         IBNK+PqLVwwKkpG8fiTNAGostmryotinPE2y+/BhKVbqOmESxTyCBx4Ag/MJrEoi0x7d
         +BYjcsWLTSzhtZNFFpXDBk6UoDI7xiHOqOkHH77imQRfnuj/Ua8ovURuwRN9R69bWwJk
         WdCmRXhZKVJZq6M3AX+3YdHIFtZq9wxAx5pXI9xH/RUDCkb8spHDhmULnYAPp1gqcyX9
         YOig==
X-Forwarded-Encrypted: i=1; AKwUvBxvN4PHar49X4DNxBWotZTIyVWCajQaxgeiToxPzmspMJQuhoN7Tf5jp3iK5XbLaBii2zQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lT2PJRpwOAT6PfbW75tfkXbbEwntVb3C9nE9Tigh4xw3E1GmYk
	mNBa3lYazS4NODKutLwZK+mLfKQnPDu4FVeX8xx+9jlmuLQlSlYQkOk/GgaadfsN9biF
X-Gm-Gg: AYBFou17evVAtHtCKstoevj7HiqfOL4fqsSDnEyIRIWBfaF0y1Rl0+BVq5Yr6MwFcuk
	BwWCs3eOshXoSVgwomkJ7u8P8ITG38W/lW5J8bqFhdHQOzEewcBkZifvj5zXnHmKn7gAucRu6eK
	3OqC/0ZuwTZQUdMK5n8WU0qu3CRVTmU1sjpVWRO2967h6DW45aKl4TURk80vWcI9+gBytEeH0IB
	j9VBAlViCUtIiF7goOoVWI+W3/1fQ4D0AHWktvftNA26a8kDmhLE2xysZZ8eIq6aJ1cpshqpirg
	SF3R1HWeoj83C6pyVmHahDbgngIgvZQ/J8PSE3DQhhEvHpcFj2ean/arSgIKO892OwvDdk2xacA
	ifdTJqdFA1XK+8m+j3+S/qirI99EZtttO2/0bxwVL/4GeMigFj+6tvCcY8LXC0d1vbCzmEXWM/S
	2soZwWS0fKd9yHYdE1lsH2S7y+u7az+BoBp6YpN5XzMZGIIBnZZa9PVGj6xMUL1Nm1sV3MnvaC9
	I2T7ucP
X-Received: by 2002:a05:6214:318b:b0:912:517b:8fc with SMTP id 6a1803df08f44-917c01b176dmr34787756d6.46.1790933115992;
        Fri, 02 Oct 2026 02:25:15 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0bcc71esm15292706d6.33.2026.10.02.02.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:25:15 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	edumazet@kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	joe@wand.net.nz,
	ast@kernel.org,
	kafai@fb.com,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v2 1/1] ipv6: defrag: orphan skb before queuing
Date: Fri,  2 Oct 2026 17:25:00 +0800
Message-ID: <5c396b7011168cd98b9812df4d6bbd00a96048e7.1790850176.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790850176.git.petalzu987@gmail.com>
References: <cover.1790850176.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

IPv4 and nf_conntrack fragment queues orphan skbs before returning
-EINPROGRESS, but ip6_frag_queue() leaves the socket association intact.

A socket installed by bpf_sk_assign() may use SOCK_RCU_FREE and be released
while its fragment remains queued. The skb destructor can then dereference
a stale socket pointer.

Orphan the skb before returning -EINPROGRESS so the queued fragment no
longer retains the socket association.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/ipv6/reassembly.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 05c51f669754..a7964125c764 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -232,6 +232,7 @@ static int ip6_frag_queue(struct net *net,
 	}
 
 	skb_dst_drop(skb);
+	skb_orphan(skb);
 	return -EINPROGRESS;
 
 insert_error:
-- 
2.34.1
