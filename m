Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB53438B0
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464498; cv=none; b=tN0OUa2x1uojAkNjr42ORoFtcRAZhaeabbbKpIglvpBugWk1L3V4NHA8NbPDWA3VdlbAm8af3F1xhkKNhAs4zeS8j7t6JTdUQMqUD3aOArxUVyHRNizBrW5bDvnJU5fkh2Kyn4WlatBfcUnjwxxx0ooQYPUnHIhtiEyTGhMNKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464498; c=relaxed/simple;
	bh=6ETYMAWu8ofZx0Y+WACFFKAJ2qtGC9uy+a+hCAKsrP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5dxnLQPoVJrbqw9S26R/0fJW3RQP4iANgFAUjx6DyeCZprN+plufzDpJuKVaw9e4+7HGJ7gX1hhKxwmWoiAn3VCG4ay9vYyUmsNUjJZTxjtUL9GjdIX/4xpQN0r40wTc+feefVFSfcA85peb9QKe2F3/BJkfiZK3mlCnpqBrOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpPIjvoX; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpPIjvoX"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66843536f94so454326d50.3
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 19:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464493; x=1786069293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tjpk63ZKju1bkNGm+aJ5Xh/f+GLe8/olsmxsdpk0+FY=;
        b=TpPIjvoX3rcrnHa8jYWkxB89VxV8ldNTsEGGEzHiBCL3IGx+Um4o0QxU2E5aocnB9e
         g3/cNUpaZz1kunK0r37Cc0/hMbm+MWkJWSdH3bLz1MMRo9t24NNinRq9C/N30ot7LqP1
         uxvk6uar55XyahJbiT3+XyKxV9bPAYb2eR0skIRMoeSKxvx9w0Gl8y5RH1UNvNftk5ba
         4tl6HstcbBsOD4iI2oTj7FG4/8Daba7ckCZ++ujaSObXqa8vrWGEKeqXpEaHg8Um4lfd
         BCmSaz1frgkP4xOjyg4HrRT8jK7DoROUdTGQHvrhSRA2HQenaZb+mxN6BFPfdNfLH14l
         dJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464493; x=1786069293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tjpk63ZKju1bkNGm+aJ5Xh/f+GLe8/olsmxsdpk0+FY=;
        b=Q7JSfP/JVAO/MZlAbbMiKqnwYCyFFaNerotAUGFp+JRODjMuvU0EdCc78HMBUT4Omc
         HQP3M6GR3nCnURS9ksyFIy2oqeqJoXeMjMuYzOiUE54gizOuz1sE8plh/vJeydeZ1Y6Q
         WWjAzF9hFW2Yq8gl7VVDOfFB5ZuruJLDjc+ZTf3qLQd8LPWfSjK8nXBGj1+u7l8AfTrz
         5xszc8WJuZO0PxrAYMrvQbhRnCx3zwDBpCeSaXBWfAyrq5Mm7c9UFj/f75pSj4RQ2ruJ
         g2glCKcWUHt5yG0XNSOrfY2L1O3DkgrtLuCCcEBO1zjQfdqqRP1OEadO9Y8PpqwmMrJv
         0SFw==
X-Forwarded-Encrypted: i=1; AHgh+RpnUqn1I+qCq9zrELodcOLu5VcriEfFzEEcTS60rfhle1qC9UKXbrYqlTBBRjWA+rycRK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdhmcdzDksKYwhNtRe/7NbprxDcGeyXw1w/FPNwUQk7bNRr78N
	9hJUsTGq+ttsb8Si0zWZNJbh4prgL8wkBW8LfrpvcjUlOxer+6tHu+Yt
X-Gm-Gg: AR+sD11lAsp4XXxcXLzfrP2HvkUisESnkp0nPfmj2+lavLb+IRUFxX9dxpWRLAE7w3W
	tYxR+KRBlvbBiKQW038XO1eYxX54vklMu+etlQLD+lcysCM7+KGy8HclfJ9NbRc9/uy0ZmYB+1u
	UNNGXMeCJEtg1IGmdgbJx0HDt0vTOmXVl8BNHtZ5KnP91QS6OfXXT74rJLar3LzQb9bdETtGYV5
	3E/Gs111R5UlYy88swxxqXKLbmFuyp9RmRAswXPQPkcH+EdcHR0v7l4ITEUd7akkzEu5UtT9QuB
	cRj1o44o7JGuRt/ZS3jWxxziIzQH79uNfulDvMvhudgG/uXijaDSLub1Jmx2jjghyFc1mmKhM9k
	dNipzKHL+zWrr8WU/907bSV4E6/7RbApu7aCEzCuAFSXDhGttyj5PBgGURzFHF14R4ite95QSNm
	Ak2Wo864xCqTAw/N6oJYrimK2IaUICdd8x6YKdmGFezMrVnock/T/GOyCMCje8ivqnDzOJgKzlL
	C+VnQEKx2MdB+4dvriE3w==
X-Received: by 2002:a05:690c:4c11:b0:80c:85e5:8756 with SMTP id 00721157ae682-81fcbb74b6dmr533417b3.63.1785464492602;
        Thu, 30 Jul 2026 19:21:32 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:32 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH bpf-next 13/13] lsm: Document the LSM policy kptr hooks
Date: Thu, 30 Jul 2026 22:20:46 -0400
Message-ID: <20260731022047.189137-14-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731022047.189137-1-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the split of responsibilities in lsm-development.rst: an LSM
exposes policy operations to any kernel-internal caller through
generic LSM hooks. The BPF subsystem owns the strongly typed kfuncs
built on top of them, and the providing LSM only implements ordinary
LSM hooks.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    This attempts to clarify some of the conclusions in what an LSM
    can and can't do from Paul and Casey's feedback and make it hard
    documentation. Let me know if another place is more deserving of it.

 Documentation/security/lsm-development.rst | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/security/lsm-development.rst b/Documentation/security/lsm-development.rst
index 5895e529da7f..fc3af206e795 100644
--- a/Documentation/security/lsm-development.rst
+++ b/Documentation/security/lsm-development.rst
@@ -15,3 +15,30 @@ see ``security/security.c`` and associated structures:
 
 .. kernel-doc:: security/security.c
    :export:
+
+LSM policy kptr hooks and BPF kfuncs
+====================================
+
+The LSM framework implements an interface for individual LSMs to
+expose their configuration through BPF kfuncs and kptrs. An LSM
+may not export any kfunc or other BPF interface directly.
+
+An LSM wishing to expose a BPF kfunc must reuse an existing security
+hook or implement a new sufficiently generic LSM hook for the desired
+interface. The hooks are then called from kfunc definitions in
+``kernel/bpf``. This allows LSM hooks to remain sufficiently generic
+while allowing BPF programs to take advantage of the strong typing
+and runtime checking offered by the BPF verifier.
+
+The LSM providing an operation implements the operation's hook with
+``LSM_HOOK_INIT()`` like any other hook. A BPF program calling an
+LSM kfunc therefore reaches the LSM the same way every other
+kernel caller does: through an LSM hook. The hooks backing kfuncs
+follow the usual rules for new LSM hooks: their contract must be
+LSM agnostic so that other LSMs could provide a meaningful
+implementation of the same operation.
+
+Whether the LSM providing an operation is built in and active is a
+runtime property: the kfuncs are always registered when
+``CONFIG_BPF_LSM`` is enabled. BPF program loading is thus
+independent of the boot-time LSM configuration.
-- 
2.54.0

