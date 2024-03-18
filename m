Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5336354BC8
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780872; cv=none; b=sLUL/zsKOuKgZ88AP0e4nW2/Zdu5G31qmfIU1450k39l2X3pLqTSg+W56b7J0Vusbw4fwTJXSZ/vCRmYLMMKgHKswn1FqX19c8vHukNz0/e+c66dxeVy0YO0uJw1/lsie31PQZjy7rtEoUOQNBjUoTCGVxHo0Jpc0Ok40nrKcQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780872; c=relaxed/simple;
	bh=00Wv3avjAWOsDU06a4tUr98A4JCYUumvlJi+zU/VyMo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qpaGTw9CNezJ7fJ89XRQczKUY95QsJxtmsiP1MofGOGvUFGrBdPJZFgkPkbRtmpLFjMx/ngYggz+cA3+0xUmqTak2CkYClDlKFkb+dvhYHn0byEjNJTvAEy3DXb6Gayv+QDxrKjsAXKWUJ59tVMrXrPXRC2qySAVbnfIz/qFcac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XsfvnJZP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XsfvnJZP"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5dcbb769a71so4624176a12.3
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 09:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710780870; x=1711385670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gg1p1fjlUsRnpdAvGtFGuWSVLxFfgd5m7y7ro1XOikU=;
        b=XsfvnJZPpFmVaf45dYV5lOd4PdmwJJrpT156qvHK3X8tQQfMQpD2pr+5ETE2fiB4Ne
         vc6mYBPxJP6aWbQIC9L0oYZ/jwp38qknYAAl1rPaFUsA2ywkHsdTwZkYttXwKTzAzWb5
         ylH60vSX5a6xzO6w9udQETebfcSg/D/kq3URRfW2RcnHhy1gwb09Bvfl6w3PYNxI1TEz
         5rgIgdCy0kSh2oTi/4Ykw9Fg9WPXARtIfS8yYvaDHDqG8GKmF9fk4Cuco4qA0g7bR0H4
         4K7BeIPE1WeHuS8VCpRM9GiRTu2LDomNPcOJkjrjv528smCm9gAi92zNyTfwCzw7hCam
         aNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710780870; x=1711385670;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gg1p1fjlUsRnpdAvGtFGuWSVLxFfgd5m7y7ro1XOikU=;
        b=VbeDUG2nNBMUMb2V2QsBwB/jFnIwyk3RLmqu5aowpkmTEZ09M0uLXKW1iC6DbRbImK
         zzdWXt8HMSPDQmLVXfh0qBrGg0JTGXfi6gDcOn0tRdy1KAr2ZYaW/iGKhp9aDDquLJPM
         SSDX79L4fAMtVZD/8QZkE5PeuQIehhw69FgJwcg0r19pddqsxVmzevmanxBFJX4tLSxs
         WVF7k6xsKUwhzYvgiX/xdIPMJB7xoX73T+QFcw+JCOGxENQ+O9OzvUuGZ+4vKiv+6hT4
         6faZsDgEqBqWVozeyfzddqcXisr+Jcstpd6EafRlGm+zhl6c/6vA3sTrQDpEGh3zjHxE
         0F0Q==
X-Gm-Message-State: AOJu0YwgzCVYSGtcyHfbzTgTro0JabQZyo2PYgdhuezzG2qSLXYSuVM8
	AW7ZZGOqOyoxfC1jKSBJco/nGhGBM5aUwxcly6lh0dBAuHuprYyHu+/jBU/U/mEsVDMR9LzbAZt
	HS1Aw/CFHOhRZ1C+Jz2oOzFKeTz3Zpw5zQgxxFqqX/11NE84Okd42Zak/fJGSGvO5XTpLeghAra
	dzz1OTVkNdF3+e
X-Google-Smtp-Source: AGHT+IF39rl0gzvD/fWI3Z4vwmpY+riysI2AVh3TNBokVg9Nuq/pc7ni7FRAkhYs9kFEFk+xTzsic7M=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:5812:0:b0:5dc:23a4:3a with SMTP id
 m18-20020a635812000000b005dc23a4003amr30317pgb.7.1710780869154; Mon, 18 Mar
 2024 09:54:29 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:54:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240318165427.1403313-1-sdf@google.com>
Subject: [PATCH bpf-next] xsk: Don't assume metadata is always requested in TX completion
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	Daniele Salvatore Albano <d.albano@gmail.com>
Content-Type: text/plain; charset="UTF-8"

`compl->tx_timestam != NULL` means that the user has explicitly
requested the metadata via XDP_TX_METADATA+XDP_TX_METADATA_TIMESTAMP.

Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Reported-by: Daniele Salvatore Albano <d.albano@gmail.com>
Tested-by: Daniele Salvatore Albano <d.albano@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/xdp_sock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 3cb4dc9bd70e..3d54de168a6d 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -188,6 +188,8 @@ static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_compl *compl,
 {
 	if (!compl)
 		return;
+	if (!compl->tx_timestamp)
+		return;
 
 	*compl->tx_timestamp = ops->tmo_fill_timestamp(priv);
 }
-- 
2.44.0.291.gc1ea87d7ee-goog

