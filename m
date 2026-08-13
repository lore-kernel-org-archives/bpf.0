Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5272DF144
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580812; cv=none; b=s7ccEPOt9J1i964FXntMYa/5KIguKWWywINtI1HnlsgYmwJra9hN5KUp8n/OGHcrJhrtlXA6CO388VfCKjAZxYjZRLX9xOIslB6sDK6R1sRXkp1EOvocoWcbo9/LS2fzpwowsXZARXpzdpyUyIhBgtGrrruxvF8yKAAkoIuA+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580812; c=relaxed/simple;
	bh=veTqDKWVWhuIMMVDuiWZUa0YQ97OCY9TCpyTNIzkWzs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VPxd2A/rtQ0lzey4zpHElzvjXQaERlRqDdw6AwsXd02xL/l+QMyyYBLBEXJdCpyQ/Tq2LG2ExtF/ad8Q1Dj/br3Ix7NwOnPz29t9+Cxs9c8HYDLCjzI1xR+8anjzjrmajSxOoQoHOvKVRCa3cAq276FJHq6VZ6d8rm5jMehjnhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BpGa6Uw+; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BpGa6Uw+"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca8aee88725so2185828a12.3
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 17:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786580811; x=1787185611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MCduZZ2cuHkGfG92sUop8F3LbOgQDBWvf7V8w/75FyY=;
        b=BpGa6Uw+JcqlAX/GhW4ZSNPN+9v2CEFpjqNXk0pGEXz6J+uuTcwqCHg9/ElHQpJi3c
         GDG0+IVoRU4qrKKjrdWPaS3Wr36fe0kQVL3ULLZ3B4yfDVy1I2ZZonLpi61GfG4HmzcW
         kDSf0+91GW1oa3JydlwgbtsqPPqjhZT+gQwf0aBFyFq1Z7+23zziJ49UN0+8+wB0C/t8
         RZ/Cjr/lPP5IYsWAjpZEKu5t09Y2xlNU0Y3MHJ2W0X1c1RUOXx8oJobQL6nshOX+c65w
         xnFHAfGZNi9iUw1iLx6MhEJAm5BZALdEIiVU45+yf5vq6onxhjjKbATpT4UMXxgrT9wX
         G45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786580811; x=1787185611;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCduZZ2cuHkGfG92sUop8F3LbOgQDBWvf7V8w/75FyY=;
        b=BzoMtpneZYdul0CB/5JLLWt7uKp0F90tF4Kq7k2crHzf1xQte0WRcjiT3ecvYQ2ZyB
         8m7YjDlVQYC3wyeocNCLIIupm3pWmHD0qUYz1Q8xY4qnRGkiEgbSZ3j/tLO54tg2aLfn
         hAbo6wagMFnZc2Lz5cRKB+Va6ql1mhdTG2SxphhY2Wqn7Unr1+klqHNB+9A5Wkhim3HC
         meVbkBzluel9iAQThg96GIw9VTXzM6eWawrdlPP0/6EETaN1lfoTiwMuzi7crXv+7Plf
         7o8EovVsuPxes7ngp7vrgWc/BZB6b/HGlVUpH6JcEpB8290/y1u4DKVzMVu6e+a8UZuu
         3i0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpmFpDoyVnfn81IqYokGYmj6b028lCQ1P3lGYW4wl/wkhz/0ZBquSxN1eTGFRs59PkDpPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygY8jO3MDF+4+/ltSNCx768zQ9iZUXn3KBldequeNKxLRG0siI
	Q4O5a1o13lZLNTN6ZjgPs/X/woEm0AIoEPVdSnQdfk7Fx+wdfj+nDiGt+UH/pWFiLwQx4wIxV+Q
	hHg==
X-Received: from dyw11.prod.google.com ([2002:a05:7300:880b:b0:313:afba:b76])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9211:b0:3c4:397a:69b8
 with SMTP id adf61e73a8af0-3cc5539bfb4mr3469072637.21.1786580810724; Wed, 12
 Aug 2026 17:26:50 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:26:17 +1000
In-Reply-To: <20260813002618.3755631-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813002618.3755631-1-tweek@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813002618.3755631-5-tweek@google.com>
Subject: [PATCH bpf-next 4/5] selinux: Add BPF_LOADER_LOAD_FD syscall permission
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jeffrey Vander Stoep <jeffv@google.com>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Eric Suen <ericsu@linux.microsoft.com>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Sid Nayyar <sidnayyar@google.com>, 
	Neill Kapron <nkapron@google.com>, Eric Biggers <ebiggers@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add the BPF_LOADER_LOAD_FD permission to gate the bpf syscall command of
the same name.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 security/selinux/hooks.c            | 4 ++++
 security/selinux/include/classmap.h | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7c5993f6954..b4ff5ea5306d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7196,6 +7196,10 @@ static int selinux_bpf(int cmd, union bpf_attr *attr=
,
 		ret =3D avc_has_perm(sid, sid, SECCLASS_BPF, BPF__PROG_LOAD,
 				   NULL);
 		break;
+	case BPF_LOADER_LOAD_FD:
+		ret =3D avc_has_perm(sid, sid, SECCLASS_BPF, BPF__LOADER_LOAD_FD,
+				   NULL);
+		break;
 	default:
 		ret =3D 0;
 		break;
diff --git a/security/selinux/include/classmap.h b/security/selinux/include=
/classmap.h
index 453522ca87df..4c6cc71b233c 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -171,7 +171,7 @@ const struct security_class_mapping secclass_map[] =3D =
{
 	{ "infiniband_endport", { "manage_subnet", NULL } },
 	{ "bpf",
 	  { "map_create", "map_read", "map_write", "prog_load", "prog_run",
-	    "map_create_as", "prog_load_as", NULL } },
+	    "map_create_as", "prog_load_as", "loader_load_fd", NULL } },
 	{ "xdp_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "mctp_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "perf_event",
--=20
2.55.0.691.gc56d675ccc-goog

