Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AE81D5174
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769291067; cv=none; b=bEGKRZ1T4j+MwnIDzKE+rqllPxU3tZiaJ3LMyLLnsVZoPps5AwPjoIV4KIwaEfHXVbbRJblK+O5ZjBk93nR5Wq32GQJKkifK5Dv+HfuJOfgCH7BOKbWWNRG2KTQzW2luDrSDqcSLO+sMFSmKEj8CTgIQb8LVFcpMNr9UqTQMYik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769291067; c=relaxed/simple;
	bh=TpxNbUYX0vxZyI/XEjolEVwVvHC4xab9UoFI6kJ4+Lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ksgsZ8wA6WTrQ2PSo8hkLuICRSk5La6uihTuFBx4bBmTl9hjyvoc+aJ7Rn1S4gNN/LuCB8mPAJkHAakX0JO2OVPrNizFTtTUYR+jKq4j3c2p8zfrq0WaxlIcqjI7P8yyARCsPj/mOST3LVFht8MCH5RAdiBW+FN7XAAcY628Wkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiPKNw29; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiPKNw29"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b883c8dfb00so692670866b.1
        for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 13:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769291064; x=1769895864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ouyK6l4CNc1+H+FsEEaHHeL8BpAWmJe2F3XXSg1Lvqc=;
        b=fiPKNw29tNeCLEVlGag3VsYgBolQesqmv0o6jC2sLJKiTqgfbD8mJ3X+Vt7KVhATGY
         EHbvt67DtnZgvrbbzyY3W5v6Qd5UREB9tLbD5/QOgF6fxKPwt5lDOKKDfKHPi92SXuTH
         pXDCSu9DoCGwjCB8G4Fwtxn5c8SOcTRzLkk7Kua35ijaarKThLgWdZJqJY0iM0Y38nV4
         zvlMeQEeZ167TI4cycNMYAy6eb7AFEkPQ/ZSKuLQbqL54t9MGJemAQd3s1/j/eG5PHzn
         NvbSH97BkQ2NKKgr2rhGgRgpRWFC+elX1IYnrSVXE0fiDNlWmlrjA4fU3GA6dOMKtViL
         VNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769291064; x=1769895864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouyK6l4CNc1+H+FsEEaHHeL8BpAWmJe2F3XXSg1Lvqc=;
        b=r+XTJNUSn6zisf0gUyrf6Xd+XQIaU47rAnaJoFT0oOArA8OW0te0LmXysYFPz6bpnE
         ZXBXEAy2MtHhtd02MhSYvtRs78gwPySbi3+mcC05Zq7qzlqBBJ+KmBPnwxWRxf/wFmCp
         YaW0GCGfeNmfPRXvLmYEHpCqmvsoULSMfD92ruJV7B3KzO8rqIu+lJY7DuGApzciKbd9
         Oz7qKzmcp4j53GtvxFl3lgJwifBG7i+HPhQrRpFhcVBX/krfU2DIMjU5Qic0wdXicrrf
         ifd0qbKTNjq4VUiTvKqCm+326YOxeHCT6WxkJkdyEPCyiM0IgMq79jsvlfRTglvI7sLi
         Gr8Q==
X-Gm-Message-State: AOJu0YxZ0dds9PEjh3r63NpUvJlqlb7xGw8GLUSntfFtAzK86tjFN95s
	77QOZf+UaBxZHWMo8oEFJ4M4G4euFPFcN4U48dv2bWByotCL57tQZVyzamm4tbMR6z0=
X-Gm-Gg: AZuq6aL+swSxjXIKi5fDq3pfdrflRddL0GeYfu0AhCrRiMbN78ykc6s7cmVdeOtOuNl
	vlALV7op35qNQVeqGxR78JFVkcv+a2shInN+1Z23u4tq3zfNzdXxqxpjnYpnfqiy+MhYZMlw4fI
	xg6SbKGKnu2P8mfNZ3MhODLhQQnbEy8Vqb6za2j/oOYq4udWxzvRbZR9hXpkeR3M0900ajwOAx2
	kM/xKekGqg9QrzXZA6fcycadVlnuTVV7sT4RUucqAouJaDGqQ8O59Zb0EYOPjOyefNYOTEGOyvh
	CLVDoSp6F5erqYBBf187/IkOeJIyNDvYc5F4CkLkGnZhioUNqOU8ZUhlGvpPrkveNdIQ8teHmkb
	TiPK4D4pcA0wX+rAnQpOWtb3ALTALHufd7scBrn7TzTrk395GgP4sRo1QD+Ttj8DUtk0ZDIk975
	fW/iobCV1NPRM=
X-Received: by 2002:a17:906:4787:b0:b87:fc5:40bd with SMTP id a640c23a62f3a-b885af085eamr560217166b.65.1769291063981;
        Sat, 24 Jan 2026 13:44:23 -0800 (PST)
Received: from LT2202712.home ([2a01:cb14:7c3:ae00:fd23:5d51:71d7:5f4a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b6ff080sm318060266b.38.2026.01.24.13.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 13:44:23 -0800 (PST)
From: Guillaume GONNET <ggonnet.linux@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	Guillaume GONNET <ggonnet.linux@gmail.com>
Subject: [PATCH] bpf: fix TCX/netkit detach permissions when prog FD isn't given
Date: Sat, 24 Jan 2026 22:43:28 +0100
Message-Id: <20260124214328.185113-1-ggonnet.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since c8644cd0e, BPF permissions are indirectly checked by having a
program FD or bpffs ACL. When using BPF_PROG_DETACH command on TCX or
netkit device, it's not required to provide a program FD. Instead, the
program can be specified using a relative specifier (eg., BPF_F_AFTER).

In this case, there is no permission check as there is no FD involved,
so any user can execute that detach command. This is problematic when
BPF is used to filter out packets not intended to user as it can just
remove the filter from the network interface.

For this reason, require CAP_NET_ADMIN or CAP_SYS_ADMIN in detach (only
when the BPF program FD isn't provided).

Signed-off-by: Guillaume GONNET <ggonnet.linux@gmail.com>
---
 kernel/bpf/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3c5c03d43f5f..d1600aef6e03 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4563,6 +4563,8 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 			prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
 			if (IS_ERR(prog))
 				return PTR_ERR(prog);
+		} else if (!bpf_net_capable()) {
+			return -EPERM;
 		}
 	} else if (is_cgroup_prog_type(ptype, 0, false)) {
 		if (attr->attach_flags || attr->relative_fd)
-- 
2.34.1

