Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736059;
	b=UXYbeigKXzY+zilryi9/2vtwk3AmC6Ltxd/GGjGmGUPJbRMuavv8CzI86VMw7qyyBkEW
	 4CQXOQKMVzXmHWyixSHENvzF4Y/exsRpfSGT5LkaKwmKz90R6ail/Z28kheHCNp7o1jwj
	 ry4CgKvtrMX0pTOwVs7Hio4HFVBQYIOLB4vdY+lwGP32j7D6qtcUbr6I6WmGRRWQiWBHY
	 AlMhRBmvCb9ljVFg2LwE50FKsB1NMpsK1xp8wGXoZhzzTol6qh/DapX0noNauQ1NCMrmU
	 7yW2ECy5TWAQ/kV9uMJVqhkYADc5jPK9oY60m8GUZ8iSmtE5qGHUfS2nGAefgwIJi8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wkydveF0zq5jAFEFr/DEfHBHOLC9wRiqiIlprBvXT0U=;
	b=tfk30YVTryP2L6F+tE8B1jionA/UTYKQmI0QxaUTSqwEOBX7BkY9LMtNTBSf0UBiDGwg
	 YxuYZVeT6Hg6lMFIARZsdRWxuE7iuSTBGs7YY4XnbT/8ZbcrVpltgNtgu4AjvN5q5tqBv
	 SjS1wC3JX3OH4rfeO4LFVgsE4v8F4wFPTGpf/olCkBG3cb72Bgwg6WQaDCu707xBrA6+3
	 sl9aEGNNrOBatTTpJm0JyjZnUAZ43W+lBZL8F4rNC09bhKClT++tCJ76xQmlcqJlulRUy
	 9tCpKS03scdmmzs8C063CboGcosuGJWmGemQcqdOe3Ol7r+LW3l4/P2oq1GdzzWLIYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="F7FIs0/3";
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5183A606A32C
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 20:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5183A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=F7FIs0/3
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so7053563a12.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 12:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793736058; x=1794340858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wkydveF0zq5jAFEFr/DEfHBHOLC9wRiqiIlprBvXT0U=;
        b=F7FIs0/3+Ty6jo5zAhl0l4yDHXyXiG1N7o1sAt0wUS/AVTpd3WJFSFbtxNqjfBVZ/F
         BTb/33O8/v2FPTbLzj6815/tzeGrsxvkee8XbbNsxwMOC+XhJ3PKOzqbFLoydaQ0kfr0
         vntwPSg34Knm3kb3ehlKMDdh2om105Vbf1JhW8bfpiDmGJFRL7Wuq7iBHzwUQ5Q3lGRk
         OSH8zkn4mWYp+2BcjTJa6JrqIkWb41EGFuJ81VtOTmCOtGV3bsCDLBnVHN5BGZ1zmEfI
         LPvMW+pbjg4Gx0TriFAGdrLHOimaedt9Xv3kvmnmGRbtTekGJAs0Viis9pG1QysXVBh6
         2cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736058; x=1794340858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wkydveF0zq5jAFEFr/DEfHBHOLC9wRiqiIlprBvXT0U=;
        b=vDGEZJ9ddVSOe/NfGhP+c/ZBc6QgRLXQDRSCX1BEckG4M6IAiRt791S0nKsZADY2iK
         1AanB7AxCoMtXBoQ3hpNiQgypa9m8dHhUWzN+c7hALuXqDyYBj2JPl558K7k3NFlG2ZK
         LeCAI/3Gg++rNWlL3gBzkJq9oWZpKrwdv7h6Hir/kDKgRoKDYRRL9d1AwRvNRhcXAX7m
         5pOtMF0ySdAn6J1NiaZOVL0oHpvHRYc/z3qJ+VR+3uXh+Ddu5kxFZhjqGHbN0orLEg5r
         9D18+c8VQgBnQwuauxfNqZa9xD5NbS0WYlZZzZHuQDIahK/t4eKYaKav1wQwTRu1/2z5
         Qazw==
X-Forwarded-Encrypted: i=1; AKwUvBxbYMTqgmtI0O8tmBQFPUSuk9yQZHveuVKPQ8Bu4q9cREoUMJvZf8oCv/CLmdkIzt1DnGc=@vger.kernel.org
X-Gm-Message-State: APuU4Z81aP6Zf7bY14QhHZoxPT0tyPLkqDpOpSng7fz5HnMUmSL4qfTm
	s9iyRqrDC6vltLcWnerUGMW9U8aq/ru2uZGpo9zi0q1Ul8j4BePz6nxPgByLqlOcWrsKVLbm1Ep
	bHmm8cLI=
X-Gm-Gg: AYBFou1/BxGlmv0CabIGJ2WisBv/58cilgynijS7Wdbm2WAW8VIb7yNIDAHp6nGpMh3
	z/oQ6j+UDndFKKwtl7Pej0JOxbxDynvXkiYBG1ApYItYzSfuGWDSPxqZu0H7nGF51uIwr+9BGF+
	KBZSESO1t04Vf69rftarYNuz499rClcVKWoapE8klrcOXKIrthVISgBTtYySHZypy5aVyoxGLd4
	ToFZZQii1pPGzBTCLJmhjUsjNRbYzU9BvGvp0G1QWap3cs1UpPBrPusSF+0jH6hCmoTS1sWAKhH
	Z7jELrwRipkwzu86eFoQOYtLEa8YBb7ALg2hUdkMdhDV+ZjflsLNHrjTAkODAiPAJWnR3zeLal7
	lpHWkJnc98QKk7DoY3nQzqk8ciEa5y20gnuN2lQKMj2U4FI5PlPvyFytkDr1zVrPmKImMZYhizh
	Qvj3aE7JaX4QT0UF3qDU2AMujitYgrVeQgtDZGDh1/zoPBf/5aJIKrhrEOBLLQgk+mBUk9OSwso
	b89t5zvAfMqYwdL2nOnisNv5SvGiWUO5L7cnSOKV+Y+dsXLSEki17gQoEuFPOfulXhB6KKC7LFl
	YAlmWrqrMzizlHq+lDb5YKRqgtLuVDusXNLrvliyZUUi11I=
X-Received: by 2002:a05:6402:234b:b0:6b1:df89:7e1e with SMTP id 4fb4d7f45d1cf-6b4d33aaff6mr10849177a12.1.1793736057694;
        Tue, 03 Nov 2026 12:00:57 -0800 (PST)
Received: from D90XRJJJNQ ([2a09:bac6:37af:1e5a::306:a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec91e2f2sm4499801a12.0.2026.11.03.12.00.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 12:00:56 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net 2/2] selftests: drv-net: ping: test generic XDP redirect to cpumap
Date: Tue,  3 Nov 2026 20:00:37 +0000
Message-ID: <20261103200036.65764-4-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103200036.65764-2-tianyi@cloudflare.com>
References: <20261103200036.65764-2-tianyi@cloudflare.com>
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

The generic XDP tests in ping.py only cover XDP_PASS. Add a test that
redirects all packets to a cpumap with an xdp.frags program. It runs
the same ping and TCP checks as the other tests.

xdp_cpumap.bpf.c is a new program. It redirects every packet to entry 0
of a cpumap. It is not added to xdp_dummy.bpf.c. test_xdp_offload loads
xdp_dummy.bpf.o in offload mode, which would fail on a cpumap.

The new test extends _set_xdp_generic_mb_on() with two optional
arguments. The first argument, prog, is the XDP program file name, with
default "xdp_dummy.bpf.o". The second argument, on_attach, is a
callback function, with default None. on_attach runs right after the
program is attached. The new test passes "xdp_cpumap.bpf.o" to prog and
a lambda that adds the cpumap entry to on_attach.

Without the previous patch, the new test fails on netdevsim because ping
gets no reply.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 tools/testing/selftests/drivers/net/ping.py   | 27 ++++++++++++++++---
 .../selftests/net/lib/xdp_cpumap.bpf.c        | 19 +++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib/xdp_cpumap.bpf.c

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index da3623c5e8a9..a0de9a98d906 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -7,7 +7,7 @@ from lib.py import ksft_run, ksft_exit
 from lib.py import ksft_eq, KsftSkipEx, KsftFailEx
 from lib.py import EthtoolFamily, NetDrvEpEnv
 from lib.py import bkg, cmd, wait_port_listen, rand_port
-from lib.py import defer, ethtool, ip
+from lib.py import bpf_map_set, defer, ethtool, ip
 
 no_sleep=False
 
@@ -75,16 +75,23 @@ def _set_xdp_generic_sb_on(cfg) -> None:
     if no_sleep != True:
         time.sleep(10)
 
-def _set_xdp_generic_mb_on(cfg) -> None:
-    prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
+def _set_xdp_generic_mb_on(cfg, prog="xdp_dummy.bpf.o", on_attach=None) -> None:
+    prog = cfg.net_lib_dir / prog
     cmd(f"ip link set dev {cfg.remote_ifname} mtu 9000", shell=True, host=cfg.remote)
     defer(ip, f"link set dev {cfg.remote_ifname} mtu 1500", host=cfg.remote)
     ip("link set dev %s mtu 9000 xdpgeneric obj %s sec xdp.frags" % (cfg.ifname, prog))
     defer(ip, f"link set dev {cfg.ifname} mtu 1500 xdpgeneric off")
+    if on_attach:
+        on_attach()
 
     if no_sleep != True:
         time.sleep(10)
 
+def _set_xdp_generic_cpumap_mb_on(cfg) -> None:
+    cfg.require_cmd("bpftool")
+    _set_xdp_generic_mb_on(cfg, "xdp_cpumap.bpf.o",
+                           on_attach=lambda: bpf_map_set("map_cpumap", 0, 2048))
+
 def _set_xdp_native_sb_on(cfg) -> None:
     prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
     cmd(f"ip link set dev {cfg.remote_ifname} mtu 1500", shell=True, host=cfg.remote)
@@ -192,6 +199,19 @@ def test_xdp_generic_mb(cfg, netnl) -> None:
     _test_v6(cfg)
     _test_tcp(cfg)
 
+def test_xdp_generic_cpumap_mb(cfg, netnl) -> None:
+    """Redirect all packets to a cpumap from a generic xdp.frags program."""
+    _schedule_checksum_reset(cfg, netnl)
+    _set_xdp_generic_cpumap_mb_on(cfg)
+    _set_offload_checksum(cfg, netnl, "off")
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+    _set_offload_checksum(cfg, netnl, "on")
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+
 def test_xdp_native_sb(cfg, netnl) -> None:
     _schedule_checksum_reset(cfg, netnl)
     _set_xdp_native_sb_on(cfg)
@@ -230,6 +250,7 @@ def main() -> None:
                   test_default_v6,
                   test_xdp_generic_sb,
                   test_xdp_generic_mb,
+                  test_xdp_generic_cpumap_mb,
                   test_xdp_native_sb,
                   test_xdp_native_mb,
                   test_xdp_offload],
diff --git a/tools/testing/selftests/net/lib/xdp_cpumap.bpf.c b/tools/testing/selftests/net/lib/xdp_cpumap.bpf.c
new file mode 100644
index 000000000000..150352343114
--- /dev/null
+++ b/tools/testing/selftests/net/lib/xdp_cpumap.bpf.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CPUMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} map_cpumap SEC(".maps");
+
+SEC("xdp.frags")
+int xdp_cpumap_prog_frags(struct xdp_md *ctx)
+{
+	return bpf_redirect_map(&map_cpumap, 0, XDP_DROP);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

