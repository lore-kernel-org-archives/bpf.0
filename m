Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA0E3B42EC
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491962; cv=none; b=NUOjubX6VjVTHWeRFvAtJqEtBEzBcu48eRPKiE35eDhXZuKOS9VXZA7dS+RN3bCbZG46Wy057vHbEkCn1E7zD76osUkwjEA+ASypP7m1CodWQJsz7srraH3iZYsA3Rft+sCL0Yl5G2PpZBpHZBg62sGcEvE50SVc4RM/rsb37J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491962; c=relaxed/simple;
	bh=sj0RgPHdzxSRWqefTbTBLEc9iMK6VIez0GYU13p6wyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mgsl6+aCGV1L57IJsiAlMF58O/TF532lx0/N7Io5TOB0oZMajd0uh276lgddvE+cqOspZQaA2xig/c8UETwRqa62IEONCyt+zhXe0eGRtBskbgfBriKupOZm5J4ErIIxZSlZqC91eCkGCr1K6vHVjevJ0mGDdHdcgWB8cpj0L+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQDWyO4q; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQDWyO4q"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d7151120d6so8705515ad.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 20:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788491960; x=1789096760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UUeuOmPr3qwVczVid/enr8NtWC6XGI8w6N5wrcZYCKc=;
        b=cQDWyO4qWQdE0deOrvGxZBzlU4kids2miaS17h0LE75KIYEaADOUsm7AN+2i7t7ZEc
         hMmqPUfY1LCQW9YVj1btxec6L4L4/VPSzen2op8TpVIpwOpFPk7ETG/nwKXuYxpApSVW
         GpTasvE2kOA6waLz6uYM3IBHkfYQe44fz11XsIKSe7K1ddP1Zi66ODJFoIwswCyzhTXR
         tyr94RN161BnW7ev954LFqwJYHS4qq3hoXXcZWKbW/pwOty2w0cPde8S6OrtRrVlQwqG
         Zmp6Y2hhKN/HLXjhrB9z3YmRoMG/MeT0o986MVo4yUN90kIVPjAKOiWiZKgRUL7lN107
         9GQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788491960; x=1789096760;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UUeuOmPr3qwVczVid/enr8NtWC6XGI8w6N5wrcZYCKc=;
        b=Sgp7HAJR8ezhxX5WZCJ5wvP1NnxP5SUxAoZDdy0x+ucmkbzHMPWMdVkEXHPNFFjqb7
         6TUoWfpxBXbgUSqmKR3Ug5J2C499GNN8XDEM1AsLVCPK3hTMgGOCHy/E9EHqOoxaXgzQ
         rznYHJeqIXB5G2Gr+Z0F1JTp5bmXcNhk+8l5RKuov+HRK4Ki1QwFp5T3n6jJlm3uxbpK
         GN6wAt7t7xAqib/7zgcS27D1jJ6DAq0r3qiLjdfpNNYlkfHyIY9edz1i4hK7OtNFMiJ9
         0uaGIGgRqeuqsudzBDJdURjhMJEbuMqlP3G7B4uQitoajUzv8IDa+nHPIV+1gfZJraYb
         F3GA==
X-Forwarded-Encrypted: i=1; AKwUvBzcitSS6yiLO49I/8HcvTE6wJHmD3lQ/PpmrdZSQ8gXFvK62EwAMIgXvv0e9Vd0WbekcYY=@vger.kernel.org
X-Gm-Message-State: AFuF++lESQ9jmptoERo20BMH0xxgCqY4gi4VBphb/kYVHyFB1HrmZFoi
	rRManF/tsC+JhxWNff4iW1azcfaog0uiPBLm0Vn1lWMsWZLVXVowWnRO96ZobIpd+GZuCJvg2qv
	7ow==
X-Received: from plmd12.prod.google.com ([2002:a17:903:ecc:b0:2d7:f5:4c1d])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b27:b0:2cc:f5b8:4c2e
 with SMTP id d9443c01a7336-2db12496889mr48356665ad.9.1788491959817; Thu, 03
 Sep 2026 20:19:19 -0700 (PDT)
Date: Fri,  4 Sep 2026 13:19:12 +1000
In-Reply-To: <20260904031912.2133476-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904031912.2133476-1-tweek@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904031912.2133476-2-tweek@google.com>
Subject: [PATCH bpf-next 2/2] bpftool: Reject non-autoload programs for light skeletons
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Leon Hwang <leon.hwang@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Sid Nayyar <sidnayyar@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When generating a light skeleton (bpftool gen skeleton -L), there is no
libbpf runtime object or bpf_program__set_autoload() API available to
enable/disable the autoloading of programs. If a BPF program in the
object has autoload disabled (e.g. via SEC("?...")), bpf_object__load()
silently skips loading it. bpftool still generates struct bpf_prog_desc
fields and attach functions in the light skeleton header, leaving
skel->progs.<name>.prog_fd uninitialized (0).

Explicitly reject non-autoloaded programs when use_loader is true with
an error message, preventing the generation of broken light skeleton
headers.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 tools/bpf/bpftool/gen.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index a50540ef6521..1583150241c8 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1340,6 +1340,12 @@ static int do_skeleton(int argc, char **argv)
 	}
 	bpf_object__for_each_program(prog, obj) {
 		prog_cnt++;
+
+		if (use_loader && !bpf_program__autoload(prog)) {
+			p_err("program '%s' is marked as non-autoload, which is not supported f=
or light skeletons",
+			      bpf_program__name(prog));
+			return -1;
+		}
 	}
=20
 	get_header_guard(header_guard, obj_name, "SKEL_H");
--=20
2.55.0.979.g7e5102b832-goog

