Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390047;
	b=bVfWsoFBSiZQKgWMs8i/2+kCbHJGvCZbe2kAT1No8Xiu5vSzAyas1lHRN3h4QmOE7PrF
	 WswNG6fEc7jTMNAX7hzPEUum4vLB7ibxENNLpyzc1w+xBEX8Qd2xktVeeDwakOvKBB7SW
	 j5CPv9ITonIeZAa7V2yItgMPcD4WfUZXV59b9bSKWVnWtIy+kcFB7Eb3t1cGuA6fcUIN7
	 wotDYR3Dh3f5utQl5e3KPTrLCzYiIUB9zOWjfUvms+SjCPiMhozjJ1CtgqTeipAyTOD8p
	 RjyqLdiWZsqnz5hDuLEbYe6C7wqPPgAqsKJGkNvM7ti9w/zM4LGWsSG94rmD6qw3NmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DepijJ5mSdF6Rm/91utIZUffVZqjneqDysOMMvYPl3Q=;
	b=lyCj5+O8lRUjATBIYrlJW+frNBIMDfOXFbqVNbqrEZyx1Bcx0aB6WqXJX1a0deWI4tsO
	 1kbkuD1PQR7p65eE8hT7eaSOi84plz/61IYTU8StwGXsF5lSIiL9BaBYd/5MtzrIfBexf
	 3IK3IsoreImD+JsdYPJOZPvTw/21erX3KMZ1r87SiT/qDI3D0MI7ilAfOsXnUjwCtKnjp
	 jWic7VpMy8zn0mbFuUMbKZjBxKzDoyChC5dctBImB/aNbwNkGoAPvRHDcztiZYz++lT/C
	 TZLOuFQjYvcb4zqnTh4MAsj/VO3b7txjkQZLBoSBPkZ7kyE2sPxh9VV/eQcfT6dzc5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lp+FzaVJ;
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73847606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 19:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73847606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lp+FzaVJ
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-139b659a45eso262922c88.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793390046; x=1793994846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DepijJ5mSdF6Rm/91utIZUffVZqjneqDysOMMvYPl3Q=;
        b=lp+FzaVJEg9jeu7brmdhZ8zaEXk713eqp6kT8yjKzIFrt31p03EOOnH0fdPxP3H0kD
         A4fNXYWR5VnuEcIWLV1CZjEUaMe4YVep+8rnudQQYOEu41BGR5tPYa9LYBjz3vQOHPrh
         9CYJ6F4cmpAIBaddz5PM0GZw0CJvIkhOdiiS1sFv1ioRkDRk+S6NR7VvnP1pXSMv6+dq
         M8FdnMSPHW90/qe4/NTQH+lnfjYMa1ppu/yPk1ZFq7DzHl4u/w16ogwuc6pL1QooFuSB
         AShRoWrAhoS/7ZWN4VBG/YOp6f9HBzDrw20ubgcjIKsMMer4LbKvTswcbKc+RQE9g7CX
         qgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793390046; x=1793994846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DepijJ5mSdF6Rm/91utIZUffVZqjneqDysOMMvYPl3Q=;
        b=mcxEsRmqc5LqVq96C4TSCyZcVYJcJ9k4vXCCFiX5+vGsvHSF7nCIANwo8tBcC2z9K1
         bivRQwmnYyF0W53Xj3BnyyGeuq8D+rnSsvaiWUw8T+Ty8SEjQN2JZUeYS8PjooVdd173
         +0vI/EwO7qt0JSZC2oLccEM0mLhczk3PYpulBGwXuZJCBbZGTX49vuAo5mK3xWWBai0u
         acrjP7esaTokvrWejq9EZgRPZ7tPh43d3qZnpuCd5kV/qOIT559u4m1I9XcCmdrskOXI
         ko8DW4yjp/pR33tW/u63a10AshWcJhSR+cGGbVkr3bbCohI2JGA8VxifY9vKDYIKHSQv
         Qf3w==
X-Forwarded-Encrypted: i=1; AKwUvBznQl58oLDJ54b+gCvUl2rD+6a4yKmuHs6tbFsjuM1FTHHxTU0Ca4xF6E1dhO44KZDJYk8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyfL0EtUxhR7dvpmISNdznKBLfgr+E5SsDKy6yu7bhbKnj3eeY
	rqH34YSLZJg2u1jsHrQk1CRY3TF1xozkRUpepy3Zluf1bSz5I9SzQ7Gd
X-Gm-Gg: AYBFou01RW8qLuqcrqvRcT37634+7QKfdDbP6x9ZCkVGTWCsG0yEi7OaGN1mWZQf2zK
	Df1tdYgyVedTkC3a1yqS/VYP9nvJoCIsQneG9h+lQE3zyQNR++LA1YHDx0fHO8tiEV0XuCAwvck
	4I9BRjx42h4GKOkTHoNO2bVAuvQpzl/0urwkralbWRAkGYuZ+eJMg6qUyMluBxsznP/VCMpda2H
	e/DVtrgAJ4l9VTF/c2vMEO+ogBOwCOkIEHNrH0fkZP3OmO6p4T8WwBOw9PFuQLgOTTSbD+0RZHz
	rTURe+UsPHJXPDWfWl17d/ApCl5ntcnX4gPLNbRxoHREFzmxxteXFbqYMs21FEY3uIEcDRrIElU
	JKVl6SXx+m3ewnOFRdfGHTDYqZzRTN5KI5lpSvYlsHuCR/lZdRfOfvRrAefe0YJr9uLnhqTjFIx
	Ah2vRtQ1z++NRmLsrWX9DzSmk4wMI4bI/G3t0tjgzKn81izyggp+mPiZC445pUONTPOV2zqYDg0
	o6Espea7P6NmUolqf6iCfp6nSfYMnUzKiksfHb+bZPYWuuNjY1b9UynJa3N0ihCYmgL1F0f64aj
	wgrMnn3FKCF6XoKABypWeSxOTQO9nuIrgNdXfr5Jqf5BEd3tL9gsUdFW
X-Received: by 2002:a05:701b:4206:20b0:1a4:9eaa:d01d with SMTP id a92af1059eb24-1ac5fd08905mr4373862c88.45.1793390046372;
        Fri, 30 Oct 2026 12:54:06 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b0a628bsm8711286c88.22.2026.10.30.12.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:54:03 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH bpf-next v2] bpftool: avoid sign extension in unsigned enum JSON dumps
Date: Fri, 30 Oct 2026 19:53:43 +0000
Message-ID: <20261030195343.79712-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The BTF enum value is stored in a signed 32-bit field even when the
enum is unsigned. Passing it directly to jsonw_uint_field(), which
takes a uint64_t, sign-extends values with bit 31 set. For example,
0xffffffffU is printed as 18446744073709551615 instead of 4294967295
by bpftool -j btf dump.

Cast the value to __u32 before widening it, matching the conversion
already used for plain-text output.

Fixes: c93cc69004df ("bpftool: add ability to dump BTF types")
Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Drop RFC as requested by Andrii.
- Add Quentin Monnet's Acked-by.
- No code changes.

v1 (RFC): https://patchwork.kernel.org/series/1196994/

 tools/bpf/bpftool/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index abd661db91e6..385521e6b028 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -482,7 +482,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 				if (btf_kflag(t))
 					jsonw_int_field(w, "val", v->val);
 				else
-					jsonw_uint_field(w, "val", v->val);
+					jsonw_uint_field(w, "val", (__u32)v->val);
 				jsonw_end_object(w);
 			} else {
 				if (btf_kflag(t))

base-commit: 7101b10cf281f629ac58c99697ca6f6d082b99a7
-- 
2.43.0

