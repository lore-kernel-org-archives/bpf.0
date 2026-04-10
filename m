Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48293A874F
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854580; cv=none; b=BSqea2WxPURP2jHCSu3K8o55E0bcrXUe6IWtDVwe2y6LFjMykOWQgF0IAWShK1rwpwYQ/Ms2aBjAj1ah5uH1/VqzbpUm9aqTLIHBsnCSeFD2BpFQOXUUK7mfXqbP0lu5PS9wlfu4uROOmBKkbOyWCTnV07EOuVfH9qY1AGhA8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854580; c=relaxed/simple;
	bh=62Ix46kA1Xz90T22xspOOMdXhfiODw7H57e1MUPlBUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HP8ta8SiRPIon4jQ2P4LS3v9xFVZKsCxgd1+hXcicn2Thgmj5Tj8F6PaaLuWq+ZeQeJSSY6I5VRQX2P4rV3TRPwBR3eyN3g3vJZNfVEX3rGKOffcbtKXCKMbuAjYwWG9v9Omv/tDUL1nYDmhnI8r/e16C8V7v6UhRzV+b1ZiOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoPAvGmO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoPAvGmO"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82a655cfab5so2382266b3a.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 13:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775854578; x=1776459378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H++hNpOnRmeKqCmKO1D1mWWdRRxARivrhqFGJ0EFx3I=;
        b=SoPAvGmOvWWDkp5Pc6necYrlB98yh/XywwBjqGi/UYsXeOgeDJNZ0PPzhS0VuCFWde
         YJW4tmi1LNEPYwLkyiTd6+gikaGR8ocDF3szjKrHJgWCN3po5XAvbxyP/isxGm+45vz8
         R4YWqgBAkwEgcumJNtea6wV84yBV3CWGsetmpzS0Y+ZdZU1zxk0vM76NfESnQy25tU1u
         E8vKnD5Ao0IIY5WsaxHW/qhpOZxJLCDY+7ki1v0FtqWfBAitOuEaIylhvTgsMZSq5Rc2
         rUvlRix5FeRN5VNCJKvGZzehrvonKJKJsPzD8t+L8c05FKRBBrlAP930kWtUCcaNZa4O
         3sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854578; x=1776459378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H++hNpOnRmeKqCmKO1D1mWWdRRxARivrhqFGJ0EFx3I=;
        b=N+RXcqx8td3xK132UwPmbKfoPwLYPZij7MIYRSJ01JBefz8SxUjuObektY0uTvA0Zf
         Rgyh/Y9l9zByg9yj7H97ZLARBDTR44M0pIPbCQOwD6COsItXYgs2mVfa48riocyRkRJN
         8SpiyXTRf6w0W09PELmUNFze25axjUCy93hYcG2YeoFDHmNGXLpsIqBwOtsiyPhUdFck
         YNMQQC+mp+PVddsOtIsfOMwMmi1B842BSZkuAEOphIfNEBSOR5TBKUWrQLGIHPu1/KOw
         +BEIhdZMGnc1ktQQ8+e0Dem3GvDp8cl3AhVf1ZKwkArsxBzwya5Q7hPICmVGEimpm64L
         h7/Q==
X-Gm-Message-State: AOJu0YwHxzgbN9o+zIYgkwyxsugPKUFQC8N85z0d8owvaZT3CZP9VyTP
	QRch8cPSk2siByY9aqpMLYB9KrMGHolaRIxXEGHUsKmfHIsJP5w8WaXD2eDtSOx7
X-Gm-Gg: AeBDiesQe8oTxJXFXjM/5jCVMLebOjnkRkkCJXohjmTHik5s1qDBWz1iG2GzOPAuTYt
	KwOwiDDAbNb7dHK+xsH3Brx8P/qJ3WmmCjnYWol8KhjzAGLGfNPra3Gw5WzccQhvhFICqqXp13U
	eiWxqPkc4CwcAHJtyOirjD8ADDOprtW/VE9h9zMOX6XnD9gwkY1OaVhEyKEIGNmH540wVOIJYB+
	nIdKdCKmO9ONHPEc1MZEj9hCg0UtfiXNlk2q8wZOYK1lv9BDYdn4Vwc+ogF7kx8ZarpyE0WSG92
	C/OoPGDvVQSZHsCOZMDd8lQO1/n0/gIFKuW54vCqwmuRt88eVx7ntLofT4o6sAocjeOkXOyNFEL
	E8p5o8VT145yIKtNdpzzvu1kxAAISHcswW0Sn9L5msuAnpwaSsxLRp+r/7v940W1B9U4Yt3DJTg
	rTm0c5eU1M9jTQqtDwaWGHudiaZ05VaHjNvQ3bmX2qKqoNjWaH1g3hieFJ5h99MGhjo1w=
X-Received: by 2002:a05:6a00:bd06:b0:82c:ec1b:9e0f with SMTP id d2e1a72fcca58-82f0c1e229fmr5779915b3a.3.1775854578059;
        Fri, 10 Apr 2026 13:56:18 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50a8f7sm3551648b3a.56.2026.04.10.13.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:56:17 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v4 02/14] bpf: save subprogram name in bpf_subprog_info
Date: Fri, 10 Apr 2026 13:55:53 -0700
Message-ID: <20260410-patch-set-v4-2-5d4eecb343db@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Subprogram name can be computed from function info and BTF, but it is
convenient to have the name readily available for logging purposes.
Update comment saying that bpf_subprog_info->start has to be the first
field, this is no longer true, relevant sites access .start field
by it's name.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 2 +-
 kernel/bpf/verifier.c        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 15f7f9f35be9..cec6054d6333 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -664,7 +664,7 @@ enum priv_stack_mode {
 };
 
 struct bpf_subprog_info {
-	/* 'start' has to be the first field otherwise find_subprog() won't work */
+	const char *name; /* name extracted from BTF */
 	u32 start; /* insn idx of function entry point */
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
 	u32 postorder_start; /* The idx to the env->cfg.insn_postorder */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dd81cfbad680..cd2a56308e59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19682,6 +19682,7 @@ static int check_btf_func(struct bpf_verifier_env *env,
 			goto err_free;
 		}
 
+		env->subprog_info[i].name = btf_name_by_offset(btf, type->name_off);
 		bpfptr_add(&urecord, urec_size);
 	}
 

-- 
2.53.0
