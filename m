Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E835203A
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 03:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785468253; cv=none; b=MYIVX5gkBJO4XJiqjAdQ9xdCJtunpSJ1o4hRknPBkKbWPYbm8Ttc3/m+/s5FgknBUxJq/D31Mt3ugaHfXfeeKyMGZ7uwxakWBegcxilBWANJA6wKSdoBcDoJykMekGNYGh7RJfZ//myA+12GC0sU4UmyQ++oyaKN7Hmcf3haQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785468253; c=relaxed/simple;
	bh=TM6yUSd86T9c7CJH0RLQPcEvuqoCm5mVdibybM7ldkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G2iqLdB2btu659AUGrlC6PDp1egfsNNQV431QYrF8Z2K4c0w/CTKeINSONJ048/R9PsQou8x2DeAHiCgcOk2LABH2GhYVXaQGEzAktqanDBrFpNufffONzVCmtStu3gYqpsBKvZuLI4SkJlMWeAX9OOzOqwyqie294HrXaVyjiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIZo1B0M; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIZo1B0M"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cacb8416a1so5076155ad.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 20:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785468252; x=1786073052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cGFm3V3bJXmwLL5Y2WlirnWL5iEhwpm4whM/A9IFBpw=;
        b=dIZo1B0MwFF5HY6ddBWNgvcSlISARzNZmTze+vt/1EFlA1c6YbWwSrb84nJzQoYcQ/
         zb3o4btck9J+b29w0wNtDGscSeU3Et0WYwbL9gnmB0gzvZgP+a2a+eZ4MAKFsIDnikDX
         dmN0ef9q1EZFb2NTOctCgF3PKoeTQuesthI+alWefXXU+/84bdDRqv3TD/ntA+gYWtTQ
         HHm2okYJVIBRszUvU+NCcJqSUq+j8HFeZ4yZ9gFv0xqq68juBLsKNseq8I7g3ka5V7Dx
         2VtXCKUSuiAv5RHePN64/YFgP54IPWDWYLqLEhv16BlXS8oDMGMI8GqOlAWmcFzIcWAO
         TGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785468252; x=1786073052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cGFm3V3bJXmwLL5Y2WlirnWL5iEhwpm4whM/A9IFBpw=;
        b=BRAO/Z7Kxwb5kBPgOoSstMF6xT1pLBW0e7odBrys4umB3IGq4roKCXs8CvGl5czt+p
         I2Z32FIfMILQdiGhggHfrI4UkJjIV5RR3z35hYprcjcRaWq3EVYmiPHlwFz/ZgYLkwDG
         YbC75k8dc9pnz25QyFR/it0PZXGEsfYPZYvv4RCkkZ6/NQo4MRfHo0ljQUpuLaEC+EwA
         VfElpNxZMDcsV6Mg/0pmPImCvOgUrb8umKswF93wil5ZnZObsDb/D8uF4YMSlJI3nbnX
         QGpkBbybpWdqxxN1lFJhs2BSupmckAFIzDP1/MsgRzxCcGsltyYmg4zYcopc1ORV3jQn
         p/+w==
X-Forwarded-Encrypted: i=1; AHgh+RoujhBDHJlU9HZ9dn1+A1qXanzfCyVOqvuZIC5lI/Xa2gNljPbIMVX44Oo+hwNgOGBaOzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yMmabCdqXp5Nv3+Tb2TQnPd/KBOWRPJu13bs+rY7o4M/q2Kd
	iDk/SJsAPL1iIOBpYX08FbYEt7LkdGcTud6cO1nK2SdG4U0328JVHt5t
X-Gm-Gg: AR+sD13XAIrpVzMoxde45TwNLI66GSMRASfckSlRLsXU6T0ngDjVTASp/Mn3Udv70y+
	o1rbR7wWO2G3OfEY/1GncgQWn60/jIa4SmpmWVQRpgBFlpbyu4jzlPLCHErBkTH9oy5heuFusri
	q3P75Nuz75f/Y1yUGj5wTqralpzQgS079hCH1nAgXSC9q7WdfCcWMmjmyUWzEwXAc3nTN/1hL/7
	SaioycPrmbFA6l4Eyh6FVQnd+2KCcdaytyQK7u7lax+kdRRi7NYlKXGFGLKNJJGDscVnDTlyPQk
	a2KK39AWfcGD3dpy5cwL/TMkULAWz82OL+PFdCZ8kBnBVgqPlbxVtac18AtcULIjObidKKMNkTc
	46Q+KKgdEv5QdPCY5KsMMYo/a6LvoJt9bhDymXwLTo4qFvPWEMdGBH+QJSqXpCwOSU5Xs1SakiT
	vYb/awDr+DXTK8Z6F3c5BVxPqgzZ+COnM2n1xrzWf/E18nWS1gRQxJGuopK2vFFEd8e15kANlIs
	Sc04ai0UUR+TriHQ+OaaTNJ+X18lOfXi186dQ1FyYjeRPIM
X-Received: by 2002:a17:903:3b86:b0:2cf:9344:b80c with SMTP id d9443c01a7336-2d046dab155mr4904345ad.18.1785468251543;
        Thu, 30 Jul 2026 20:24:11 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d047c42b4bsm869275ad.78.2026.07.30.20.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 20:24:11 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>,
	maciej.fijalkowski@intel.com
Subject: [PATCH net v2 0/2] Fix skb length accounting after XDP frag adjustment
Date: Thu, 30 Jul 2026 20:23:55 -0700
Message-ID: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes skb length accounting after XDP fragment adjustment in
generic XDP and veth.

v1:
https://lore.kernel.org/bpf/20260727032535.13469-1-sun.jian.kdev@gmail.com/

Changes in v2:
- Move the veth fragment accounting before the linear tail adjustment, so
  __skb_put() observes a linear skb after a shrink removes all fragments.
- Fold the skb->len update into the xdp_buff_has_frags() branch, as suggested
  by Lorenzo Bianconi.
- Clarify why the old data_len contribution must be removed before adding the
  updated one, as requested by Maciej Fijalkowski.

Sun Jian (2):
  net: fix skb length accounting after generic XDP frag adjustment
  veth: fix skb length accounting after XDP frag adjustment

 drivers/net/veth.c | 23 +++++++++++++++--------
 net/core/dev.c     | 10 +++++++---
 2 files changed, 22 insertions(+), 11 deletions(-)

Range-diff against v1:
1:  b914fb40f348 ! 1:  2d716a1bd570 net: fix skb length accounting after generic XDP frag adjustment
    @@ Commit message
     
         Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
         Cc: stable@vger.kernel.org
    -    Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel.org
         Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
         Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
     
    @@ net/core/dev.c: u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buf
      
      	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
     -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
    -+	 * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
    ++	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
    ++	 * from skb->len before updating data_len, then add the new one back.
      	 */
    +-	if (xdp_buff_has_frags(xdp))
     +	skb->len -= skb->data_len;
    - 	if (xdp_buff_has_frags(xdp))
    ++	if (xdp_buff_has_frags(xdp)) {
      		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
    - 	else
    +-	else
    ++		skb->len += skb->data_len;
    ++	} else {
      		skb->data_len = 0;
    -+	skb->len += skb->data_len;
    ++	}
      
      	/* check if XDP changed eth hdr such SKB needs update */
      	eth = (struct ethhdr *)xdp->data;
2:  59c79966c84a ! 2:  e5b9383bc46e veth: fix skb length accounting after XDP frag adjustment
    @@ Commit message
         Subtract the old data_len before replacing it and add the new data_len
         afterwards, keeping skb->len and skb->data_len synchronized.
     
    +    The fragment accounting must run before the linear tail adjustment:
    +    when bpf_xdp_adjust_tail() shrinks the packet into the linear area it
    +    releases all fragments, and __skb_put() requires skb->data_len == 0
    +    by that point.
    +
         A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
         1024 bytes from its fragment area. Before the fix, all 10 runs produced
         corrupted payloads. After the fix, all 10 runs matched the expected
    @@ Commit message
     
         Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
         Cc: stable@vger.kernel.org
    -    Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel.org
         Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
         Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
     
      ## drivers/net/veth.c ##
     @@ drivers/net/veth.c: static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
    - 		__skb_put(skb, off); /* positive on grow, negative on shrink */
      
    + 	skb_reset_mac_header(skb);
    + 
    +-	/* check if bpf_xdp_adjust_tail was used */
    +-	off = xdp->data_end - orig_data_end;
    +-	if (off != 0)
    +-		__skb_put(skb, off); /* positive on grow, negative on shrink */
    +-
      	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
     -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
    -+	 * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
    ++	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
    ++	 * from skb->len before updating data_len, then add the new one back.
    ++	 * This must precede the linear tail adjustment below: a changed
    ++	 * data_end implies that no fragments remain, and __skb_put() requires
    ++	 * a linear skb.
      	 */
    +-	if (xdp_buff_has_frags(xdp))
     +	skb->len -= skb->data_len;
    - 	if (xdp_buff_has_frags(xdp))
    ++	if (xdp_buff_has_frags(xdp)) {
      		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
    - 	else
    +-	else
    ++		skb->len += skb->data_len;
    ++	} else {
      		skb->data_len = 0;
    -+	skb->len += skb->data_len;
    ++	}
    ++
    ++	/* check if bpf_xdp_adjust_tail was used */
    ++	off = xdp->data_end - orig_data_end;
    ++	if (off != 0)
    ++		__skb_put(skb, off); /* positive on grow, negative on shrink */
      
      	skb->protocol = eth_type_trans(skb, rq->dev);
      

base-commit: 97ac08560d236ca17f6606d9e671118e5eae5721
-- 
2.43.0

