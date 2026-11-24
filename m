Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.171.232.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795488407;
	b=hZv+ORBO72tCyO+9ie67dFzSbhGR42nYiu9FbwH4WnhoI0ToF/kUGP9XhTGc0bbWiChj
	 j6sPNdaBhYBsTCCpHgI9p6GBmBWoZiO7qv8mUSfDBe1yXSmHdnoZg0vHmcD/wETsAsidS
	 Oz8XY5EPdaKQjuPBvBy346U5vb/w7Kvz7FVfCKtA4ScAnfvOya7Aa1kCVv/pqGs5eDwc3
	 bU9lrIieNZtoqofRPYYcsNs3b4CRG9nl+XeROnGz94bLvZo9jejIUcsptP9RYwNGJz57G
	 AQoeoJevUqrO3lCJ+LVTBwfa88otHzlghK73lGniMZ3TOMGXZFPEQz5f5j2fmbSFosg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795488407;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3Y6QHbsbiOxnfjeTTGulIuIET3vrMwP1khhqnYfjbVE=;
	b=RoDNPLwf93yAHxjpNZ3DNP17gAkLO/Cwa4pzAhuj73NNks7Rdkg5A5modQXg1zYs+ud/
	 ygfO2P9fpaOsYaW9E+NPFnpfS9wiKyJIjxAGbgybQLK/5rY+ftDD99wlGiuZtdpu8h6mT
	 ZSa68rxxbqXrbB3x6qauMa7w/c3YX3hEdFDrSeSZyCosA+wjMm38pWmDOFHbXiCQQjILZ
	 oQxK3wLTPcGE9nGo3BX6OfvWbITy3c9N9vYwh1/7w0VkcgqAci57mJc/UEU9RupilAK5F
	 wQeXN7rWXhpdqyVDUKNJYfbIMDFZ+v7UlTb5lrdFQbU19rMqQDPEkg7ul5snl+Wk+0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=69.171.232.181
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB55606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 02:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EB55606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 38B5D599919BD; Mon, 23 Nov 2026 18:46:34 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH bpf-next v2 1/2] lib/Kconfig.debug: Set the minimum required pahole version to v1.24
Date: Mon, 23 Nov 2026 18:46:34 -0800
Message-ID: <20261124024634.3872058-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261124024629.3871056-1-yonghong.song@linux.dev>
References: <20261124024629.3871056-1-yonghong.song@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 2c1ccd9a1d78 ("docs: changes.rst: restore pahole 1.26 minimum
(regressed by sort)") raised the minimal pahole version in the
requirements table of Documentation/process/changes.rst to v1.26, since
kfuncs with KF_IMPLICIT_ARGS needed the decl_tag_kfuncs feature of
pahole v1.26. Commit 692393104909 ("resolve_btfids: Emit bpf_kfunc and
bpf_fastcall decl tags") removed that need, as resolve_btfids now emits
the kfunc decl tags itself. CONFIG_DEBUG_INFO_BTF, on the other hand,
still accepts pahole v1.22.

Set the minimal version to v1.24, so that the kflag of an enum in
vmlinux and module BTF is meaningful: 0 for an unsigned enum and 1 for a
signed enum. pahole records the signedness of an enum in the kflag since
v1.24. With an older pahole, every enum has the kflag 0, signed or not.

Acked-by: Alan Maguire <almagui@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 Documentation/process/changes.rst | 4 ++--
 lib/Kconfig.debug                 | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/ch=
anges.rst
index 28f2ca63318e..a292f31f1891 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -53,7 +53,7 @@ mcelog                 0.6              mcelog --versio=
n
 mkimage (optional)     2017.01          mkimage --version
 nfs-utils              1.0.5            showmount --version
 openssl & libcrypto    1.0.0            openssl version
-pahole                 1.26             pahole --version
+pahole                 1.24             pahole --version
 pcmciautils            004              pccardctl -V
 pigz (optional)        2.4              pigz --version
 PPP                    2.4.0            pppd --version
@@ -146,7 +146,7 @@ pahole
=20
 Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
 generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from =
kernel
-modules as well.  This requires pahole v1.22 or later.
+modules as well.  This requires pahole v1.24 or later.
=20
 It is found in the 'dwarves' or 'pahole' distro packages or from
 https://fedorapeople.org/~acme/dwarves/.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec13a..9479034afe5a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -400,12 +400,12 @@ config DEBUG_INFO_BTF
 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	depends on BPF_SYSCALL
-	depends on PAHOLE_VERSION >=3D 122
+	depends on PAHOLE_VERSION >=3D 124
 	# pahole uses elfutils, which does not have support for Hexagon relocat=
ions
 	depends on !HEXAGON
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
-	  Turning this on requires pahole v1.22 or later, which will convert
+	  Turning this on requires pahole v1.24 or later, which will convert
 	  DWARF type info into equivalent deduplicated BTF type info.
=20
 config PAHOLE_HAS_BTF_TAG
--=20
2.53.1-Meta

