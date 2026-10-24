Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792834083;
	b=VhJryHI7BYc9Jfrff/1wQloDnGyk24GIf6nhpqqxZqiM78lUvwccriAtRVw7VMMxvXfC
	 76y/S1Q2KAJ4RKGICQl3YsknHvzZRCAtD8LsSDKRMVYRTlsZKFjDEd4oWXO2DhHZEzr6d
	 Zh8U0jJ79FE83l9BwYCIQ2azgzyPMQULD4h3Qvca3nvMNT7hLIVyXVKJSsyhV+OAYNVF3
	 W9PTINt/FcyRSN9YuMNyfw9amuuADjaB/QPWErUG+ByroqXe8wlO1INkohbdFBulSM58a
	 qdSVBt9x0NAfwhNUZ/Z/D+dLm1Gxhmhhy0FX1Ss5iRb+T3YAW7xhpPKRttqlWNBX7Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792834083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=j2rRh4N7cmK15/HNyDskN6MSE+BR1CVHfRqKHHQTGoM=;
	b=X+QH5mz3q7bBOd9MVs19rVD4DQih4vHSLBX4+i5ArlhPtzA2l37z2pD35MM4vEASmi9k
	 Pq8t5VXt+752rjKToBJNiRThl/OpuhKPL4Wetn8eDnDqW/BhC9jI7XNpI6IANTzOf1jN7
	 egHuGxiFw1SCNnAZXNgPsjbgVlX85Dbaba5vGzMYeC3aHdz6OSprOypiCgt2MYMPFBS9A
	 uE+esgwRM/i/20F8hjzi2iMeaVa92vfQlgPHLKoJ/A8v3lL4CM2fFD+HyBwbk1W8mWP4F
	 JQ96u1iC1h6C+UnTcUkVpbWGY25J47nz3Ro6ySajhUTaq+06UqLBWxU3Uyv2oo2stuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kt5wAM30;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA6B606A31B
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 09:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AA6B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kt5wAM30
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35b2c599f43so135333eec.0
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792834082; x=1793438882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j2rRh4N7cmK15/HNyDskN6MSE+BR1CVHfRqKHHQTGoM=;
        b=kt5wAM30en/eWwJ1xUWn1Q/+F9+W7xlIlkhPgwU8OW5vlcB+owd3ZNxVpig1TyYmrZ
         ODPxWvq77miY1Iw6X+fO8iZGu4ZaaRXIK+zq+xeqtYH3rQUCxQ6AqK6fOpJlAvb+Y7LH
         1IEfS25eMQ7xbwpurUIzgfgt8dYHEkilZSZ/y0KA5j3gfCsIChSX+TiCcCYZqp5Y3/td
         jVfE54k5ESPQ8jc6EW/P+Pqn91rbr97YG6BTJ2lbVxdtD1xvVUM0FZqckeM+MSZrb4zx
         UX5JtCLe09jvNpO29EikD+QGahnSji3o0o8F3Wyi7lFuECHa/4QjGTzvDxzgxK7PR84c
         WZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792834082; x=1793438882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2rRh4N7cmK15/HNyDskN6MSE+BR1CVHfRqKHHQTGoM=;
        b=CLE1A5vvM59b1Eml0cIw8kgMh0X4XFfnKju5NhpbbyapLHV42+yeSCmHQJIYU3CuYL
         om78TtiLjK6dZfPRaRRmLrsbm6CxaclxTaRlYqs/97GQTSsjacRs9viZft3E+5pHqz2H
         tpqoq13TDLjm4Py4o32HvgY6623LTbSGJXVF5tfP0WHRJbzjOpqxiAocQqk4svSnoIxf
         EG5k2D2qfbkNDgEWkLUtvYo3iObp2RVPgNSV5fh09AwolVwc6YJw5VOd9DgVMOo+PMzs
         ZLIwN5cjixx8SIJThYwUxtWFIwAaM15M4llom/VjlxNY9pT7yEKjTOnF5Xp+9Kx6F7FW
         6VEA==
X-Gm-Message-State: AFq9FYLqN5MChAgp4qna838ERXYcWnonmIJqtwdcG1GHfX+Bsnyfb0Lq
	3Fsl/QWMSs25kLQYvsVJ/PixCBZhNO6sQVTGy2mxs0dooQd6ckD/a6rqxvwGtLF9
X-Gm-Gg: AYBFou0vDxe+ADelbIAzIc1gSOWgEAq9/EriFZSzOnZtH0gs4OoHfL+RSWi2xP3oOQA
	zc7/DxF/9IQh+mqzxKP3r7qWO3RmQHZrJbgfUkdnmI5ukyvtZYBgsF/XS7NAXgOHsbS05Zm1RxC
	8NstoTfc2LbYLHq7gG/n+tZdc0WwRM8NekklwBRkcHkPKs8Z+yBfjuXDQO5P+LRkOpOH/UgAlAV
	DuBtBq1MUQgyjsBmElXYxQ4zvp5TcyPWPfyKNlBTTWOWSNeQZq8iRAJBRBwoffVV9OgRkLFsywr
	RA/NeJeMoE6WLx12vXsbwMeqRel44GYeDQBjfo0VkBwoxkwq6fMo50yBhB3iB/x9d+OLU4LFlSo
	/4HIXeMiA5rz7dFjcIzKK2OHQhmEq0w33fQg795cD0ojrPEMZpPQNdWwVQgcR1cDK2zVrYsI6kS
	PFlg+X4r598+GK/nlTTjwC9x7t9UY0y8nGNlqKVObue4nhVzjY6LNukntaM0irwZDkaK3rt6G/Z
	6+JxXsKLD6uQhPyaI8VZzef1F0Zq+c3VjRtswYt3KzKLpwy94N96Xc1sYPnJaXQCZrEqkQnmR3x
	3ECmYMLOnBwK/84KE9TnOzhawhqsgpnPVFFYntIhG+zQZGXXYJuB3aYqko/HvZ/jp7FJTu/lWg=
	=
X-Received: by 2002:a05:693c:415a:10b0:35a:7020:c08a with SMTP id 5a478bee46e88-369e846b175mr2885481eec.19.1792834082019;
        Sat, 24 Oct 2026 02:28:02 -0700 (PDT)
Received: from nixos ([2405:201:c40d:9039:e1f8:b9bb:b037:3cab])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daf444sm5236604eec.18.2026.10.24.02.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 02:28:01 -0700 (PDT)
From: Ayushman Rout <ayushmanrout27@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	Ayushman Rout <ayushmanrout27@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org
Subject: [PATCH bpf 0/3] bpf: Fix overlapping copies in xdp and dynptr helpers
Date: Sat, 24 Oct 2026 14:56:55 +0530
Message-ID: <20261024092659.76422-1-ayushmanrout27@gmail.com>
X-Mailer: git-send-email 2.54.0
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

My patch "bpf: Use memmove() to load bytes from an skb and an xdp_buff"
was applied as b93cf2c8a055. The AI review on it noted that the
multi-frag path of bpf_xdp_copy_buf() still copies forward with
memcpy() and breaks when the buffer is a slice of the same packet. This
series fixes that.

Commit ab08863c58b1 ("bpf: Use memmove() to store bytes in an xdp_buff") fixed the
single-segment store path and left the cross-fragment case open. Patch 1
fixes that case for both load and store.

Patch 1 fixes bpf_xdp_copy_buf().
Patch 2 fixes bpf_dynptr_copy(), which has the same problem when both
ranges overlap in one packet and cross a segment boundary.
Patch 3 adds selftests.

Testing: x86_64 QEMU VM, ./test_progs -t dynptr. With the fixes all
four new tests pass. Without them the three xdp tests fail and the skb
test passes.

I also read the other memcpy() calls that could touch packet memory.
I found no overlap path, but this is not proven, so I left them
unchanged: the sock_ops header option copies, bpf_file_fetch_bytes(),
bpf_flow_dissector_load_bytes() and bpf_lwt_seg6_store_bytes().

v2 of the earlier patch:
https://patch.msgid.link/20261022112312.31563-1-ayushmanrout27@gmail.com

Ayushman Rout (3):
  bpf: Fix bpf_xdp_copy_buf() when the buffer overlaps the packet
  bpf: Fix bpf_dynptr_copy() for overlapping ranges in one packet
  selftests/bpf: Test overlapping dynptr copies on xdp frags

 kernel/bpf/helpers.c                          |   7 +-
 net/core/filter.c                             |  59 ++++----
 .../testing/selftests/bpf/prog_tests/dynptr.c |   4 +
 .../selftests/bpf/progs/dynptr_success.c      | 128 ++++++++++++++++++
 4 files changed, 172 insertions(+), 26 deletions(-)

-- 
2.54.0

