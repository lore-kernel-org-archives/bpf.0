Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEDC3597B
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784463465; cv=none; b=cGJCyXfIQCdhu/ChEOt9h2uM5jSzS6Hv5zs5stJFfT1qJFpA/bbMIPJpkanG0dNhrWgmCWgNMU5S7ewJATmdIFFZKFijpjudguN+IWZcBLTrEclJhHFfPUaDttAAs/WsfSKLJjRZsdJb4s/mcZC3xYaHAyGQ+xT9DzbbTV/jGJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784463465; c=relaxed/simple;
	bh=LfkXaSmZbFbNZ0DTOiiPD65JCV3jypNGgduDjNLp8fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTAfxq4LyzabB8zFz1Fl3OAM58eGlDVki5PODbqPasof4vnIybM/zXqzf6RYCM6v3NFVi6n1FkCce0la5YPSBd1glsRL77P6OT6DoaEhTR51JdyJS7klJeMWk48cU7K/qYON1ur8ae63CT/ZEzSio2ejv0ryesHx4NrKZf3YusY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2Ce+/vP; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2Ce+/vP"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-46cbf263216so3192529f8f.1
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 05:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784463462; x=1785068262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mYnXPn3avxRWnhc4k6DlD3IoIMS2AMjoBhn7q5VbJ9s=;
        b=Z2Ce+/vPOZK0z9ALXSxVqNhGiXC21HEDAxnk08HA0g3P+Vw6fq0xv+ia6Tgts+iyuL
         GQfVb1Bun0OW66eO63qCjF5gvlz0cBe36sUvm0RMz6jn66ENTpvusANeAKQXctrirMUO
         EYfV5N+BC9vJPQ2dAz0iFhWbzPYqNsUarUGA4GL5XBz4BUJBXZWaWOFzWq9o941SzqXV
         SLUAFWCcOP/Gndh0uVrTw4sBDph+D/8uUnP1u8s7Rdu2KmIt4l+AhqtRh3hEF4l3ETzC
         8vc/0iKwFk0CgmAbBUXwP/Sc/CCEAaHS6SXBjEImV2ni4ydv7rgmlsKw/THqOaoEOrDB
         C5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784463462; x=1785068262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYnXPn3avxRWnhc4k6DlD3IoIMS2AMjoBhn7q5VbJ9s=;
        b=Z3zi0O1ZradEJ9zRdqMOKfwEr9o1rtVkFFYiFUl6gI1kM0fMwpVZHeEZG3onN6sOpy
         7yEzZ4vgZ5f29ShWGMjsg5frJKz7hUAfSd42Pwir9RsA+0bOgk8BL0pmJr8t1+WMh3+U
         jDVgCic2wNbio8V0bpay+HKDlNl5Go6be/9/vDCJbhjMYoBMrWJHp1ZJUlkxbHi94szI
         wDCjiprRxh+dc6tqvMXzYhjeIsmIvru1Qp0zbqGbi5JgcT2xyOBSP2U3P0fi2XUG0V6q
         Tt38+5mCFv1QSNeuDJnX2rdvc4TlU3IyhffAMJFRRBnX4jYm8ueBjGa389iV5EQdykin
         WEHw==
X-Gm-Message-State: AOJu0YyRXsYzJmEGvMJSBR/RsdbMrm09ewx64a++pY3KIRSYx37dJM69
	tmqfSJ0WWN5BOW05/6UD4LEdeVVQiTt38o2cvEAUS/Ts0KGjJYlu6Gxd4WMCO9gE
X-Gm-Gg: AfdE7cm4mgLWsFDVvm30kf0Iu7guJOk8W69v1ZGKAi/MwiA8OEvwtPFf2tj5t+LIznG
	uH3zTluIZhS4xxHE6l3xeZjauauj85YwPD4AJ6pZBCXkMfJvMetWZI6n3LiSBXYLevHWz73/uHX
	TunZQVorF74Uziq0yGjcj2QCrQx5hdaXvHFPM3ZXvXaCrMZCXEVUrlPflVr3oyDVdibHNIkuWJZ
	IbPUMwvCT39nHaeEe7uSqp9i4Y47uo/pkcGgsGpKIx5EYHIX6zVAPmmJo5E3hdSr0NCYHyF4dQ6
	jsbOjFyDH0r9jAPqi4lrbi2L8vSDSSQrZK3ClrRoTGUof1vWOemdb/24e2KgYz0+Mss6N5Kz8Ay
	FWwpvGzJwI0KP4wZHDCMzEOJJI01EeM11U//KW08rfI4QSpVnuKTKgyiubSdEaMzFzFpEWMgur2
	CnbVw4rM1WncGbWjwA58S/nq+4vD6H2zrnAmxqrkgE1e//bUhz3+oD/ilcEZrh58L8/+7HshSBY
	iev2bGWtweN0paKRWOceSenPzS9ndYjEBQbNV5I/XMq
X-Received: by 2002:a05:6000:1acd:b0:475:f0d1:eb6e with SMTP id ffacd0b85a97d-47f62344e08mr12100783f8f.59.1784463461446;
        Sun, 19 Jul 2026 05:17:41 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee9281sm22426798f8f.36.2026.07.19.05.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 05:17:41 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: Fix offset warn check for bpf_res_spin_lock
Date: Sun, 19 Jul 2026 14:17:40 +0200
Message-ID: <20260719121740.1547434-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=memxor@gmail.com; h=from:subject; bh=zm4W59MnF4hZVW0rEaOc+7kT4d9pCVgl4uPD3ArWxgw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISvmgPQ658vRm0I6Dl5ZLGJ0P+lA5tlNvyQfv2bUcV7Wd ef3hsclHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIA2+GP5yGd8+xzmXeFPIy ZWvX1oL0DdN03L1zffxFH9/3m7Z71mWGfzaVK3jWCvq8PjLDPGTOhp5vNdlXc1Pn7vsr9aZLglt oEQsA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Sashiko pointed out correctly that the case statement for
BPF_RES_SPIN_LOCK incorrectly checks offset for BPF_SPIN_LOCK.
Fix it by checking res_spin_lock_off instead.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index cbb1e49b9bcb..e7d4e9ba24e2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4168,7 +4168,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			rec->spin_lock_off = rec->fields[i].offset;
 			break;
 		case BPF_RES_SPIN_LOCK:
-			WARN_ON_ONCE(rec->spin_lock_off >= 0);
+			WARN_ON_ONCE(rec->res_spin_lock_off >= 0);
 			/* Cache offset for faster lookup at runtime */
 			rec->res_spin_lock_off = rec->fields[i].offset;
 			break;
--
2.53.0

