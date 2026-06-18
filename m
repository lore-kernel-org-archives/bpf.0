Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74F311C2F
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 04:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781755804; cv=none; b=amfrFImZmEZ7GdY/GzwoSl9YNdkOHhGQlwx2V/2JrPJhrjEGf/mL63UO/MTT7qXXbyr5Z6sFK9HAcYHlek0ljN/OW9CcJEW0IvqfeZNR/9sakJ1v7LdkSm1A3ki4C8XUGdbhWAfCBs3XDkLVcKfBviOTf61Yoaqow0PqDDrXtrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781755804; c=relaxed/simple;
	bh=B3ANVyfksUR6HDlfX8HTx9A+1hp8yokUbijVqHluEc8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gb9WC4jAJvlf0lOnTO6FShrhwooW/IlyeJCfl6B3z2MOAx1Ldw6wE2a+yQ4/mqRXTBh02TuJIU/sqdwEUHN3ud+Y2jV8l961K/JvobBmJeOysXB1NMSA1KTZEv5kQRvEkN7v+kGMNBC7eGDdm4IBwaz4N7wEZ/FW6P48Jairmzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GBQ+rCDh; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GBQ+rCDh"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30bcbaa5f6bso2152249eec.0
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 21:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781755802; x=1782360602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4D6tQJtkc+S9VIaVYbSEEirCEzH44vH9koH+YUgyD4M=;
        b=GBQ+rCDhNigJ+ilJcIZDWma00LpdiS4eFr3OPobY3HoV6+cQkBnzVUzSMHRCO1USG/
         4/+hbXqTlJnkQ8hLzkTi0930u6JmVeUVowwczhhz4hfqs+TgLsDV8dm9kiB8yVX9F5AD
         Z5Nx6ehRvn6r5oTf4B03pLcHUchOGRJ5otaGh/Lq2VfZGasW/u/CYK+F/bpcMp08Ghxk
         gdT7kUJw7djh70ZUEotJ5J0ExiPlVBwErfpGfYbp1BaRgSSoTF+91vzQvKO36EFHVUkm
         JoUga/4/+uQ7YLIHclcrsxz4xpbE3VmPt4sRQBx/k3kvBcbT7/ZOv2IZtO2RvGqZwBG8
         S8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781755802; x=1782360602;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D6tQJtkc+S9VIaVYbSEEirCEzH44vH9koH+YUgyD4M=;
        b=cHD9FSlfaSJNUOB/U1tAegV/8T3gwkjcHNBDBAg9ybmrPTz6szq4k6mfauVLenq2Xp
         NEcm+qmS6Rrtv9DsQbwJx24znDWTyAXLcHl2H7+6t/ikIOzEHwQ7mf3bF5O6o4irKxPX
         MvFETOKcJYti1tuL2GaTCpRKKfbg8SvsVXYJoqtsmD05XHGLMyios5MXXLnb93n6hK3L
         aGwXZcInASZbbbEtXBrTCEG1LfyoJRtCyk/dVre8HHB83JjtzJdLa2a76jBHR2Q/h/Ef
         T6FrB35nLSEjU7z1gJNkzar99DVBAmuriDJk/8d2jNefp2MS6F1ZAbwGfiiGVIPmuu4O
         MweA==
X-Gm-Message-State: AOJu0YxWCZcor0/zChPSiaInFkYwgkRCcNzqUjAT1SWtVaMgmPeNJ6XE
	CyCj9yarOpRytNRcspCRTB7Ecj7XngnLEGqOdwN0yoHce0Ser6RmLtoxrnE9QYh2dpEnSwXGpiv
	Uk+yAE0ZjTNggHVJk2afZPIKSy/jY0oM058mSaKC38FSvV1gPiVaov/0KTHYQsB6wAZg3i6Rafb
	It+Bt/no3a+M4gxLPkvplXT4BsQVI=
X-Received: from dycju4.prod.google.com ([2002:a05:7301:fa04:b0:304:d771:74aa])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:b905:b0:2ea:ed3e:13b7
 with SMTP id 5a478bee46e88-30bc996c541mr3764566eec.7.1781755801547; Wed, 17
 Jun 2026 21:10:01 -0700 (PDT)
Date: Thu, 18 Jun 2026 14:09:33 +1000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260618040934.4113938-1-tweek@google.com>
Subject: [PATCH] bpf: Fix BPF_PROG_ASSOC_STRUCT_OPS last field check
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When struct prog_assoc_struct_ops was added,
BPF_PROG_ASSOC_STRUCT_OPS_LAST_FIELD referenced prog_fd instead of the
actual last field, flags.

Fixes: b5709f6d26d6 ("bpf: Support associating BPF program with struct_ops"=
)
Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 630d530782fe..eb52ba57ffd5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6189,7 +6189,7 @@ static int prog_stream_read(union bpf_attr *attr)
 	return ret;
 }
=20
-#define BPF_PROG_ASSOC_STRUCT_OPS_LAST_FIELD prog_assoc_struct_ops.prog_fd
+#define BPF_PROG_ASSOC_STRUCT_OPS_LAST_FIELD prog_assoc_struct_ops.flags
=20
 static int prog_assoc_struct_ops(union bpf_attr *attr)
 {
--=20
2.54.0.1189.g8c84645362-goog

