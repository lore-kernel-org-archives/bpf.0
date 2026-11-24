Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543166;
	b=oJo/ZvvNVbAghIBowXl+VomAAkd9y6msYAoel8vRINJmhTI9nqnq3U0jeMduXs0jjnZ6
	 vFxwQego9Lzxyov6GWYf5eak1XwGjQdm7A7DnmAJo6kfP50lLKU6NnJjuL6TJvOVs00Bp
	 lHrxpwp5HbadZULh35TmL9Ku/LuPGrHyKpilSqQZ0yEPu9zAAgJoB1zQ00VQXDsoLTSYo
	 kRRUqKeRfQKPuAgV9+ZGzEm8B9pGxhP24qodW7wliZkLFshs9HWONhQF/lsR8QbuTUdu2
	 msCxU63iPcyulnW3bL3dake6npL2/waCaKiuwugUGCUt+Nvgw8JgLCsGmuImykmSqFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pcVobQ6pdsPePLIZ/BBz4G2XF5J7pWqm1D1h7L58vTo=;
	b=GFcmjw5MLB4jObFz1jgse687bGmiDkmQ4qeP5qE0+5Q1PlQJUW9fSeSTG9119yjyWevz
	 mQeC1TjgRSPAfzxalmUvXty7PaBIGYQ1EE8XMB70UN65DoWOzZPDJjuecO7NVjgelh8e4
	 EgyGutySSOcQMQT4PD0Krmay8ri33/wOEUkFJPOq0DO6I6qoqPk78+clT6HILQkwvoKa6
	 hSueCTwAv5GBC8DG1qaKJtywtRq71ZxDwChshLoMzHXbKuIGNwgp/BOVeoHJXcJW88e9S
	 E310NMxpQzA/YqtZ6S6nltIT/Eu7RTHPeco+ZfTHQ60TrS8cQ7wHevi/AhEkiBONomw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=RbQ6T5Qp;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D87606A323
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30D87606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=RbQ6T5Qp
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6bb06dc1fffso1177493a12.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795543163; x=1796147963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pcVobQ6pdsPePLIZ/BBz4G2XF5J7pWqm1D1h7L58vTo=;
        b=RbQ6T5QpLfALEMfapC5vQwcS0KOt/80cKI/2Gi7pbzKqt57N/lz4lsvjiO6176/M5M
         TWg6bDy//uuYAiZAxssulqNVo60OUaUwbHvfj0ax+USx+esigVyk1vwIoSEhNK+UIJ5f
         jIurNhrr96uyUte3jumNHscfFOZaMbWeX7dNat3a3eIQVHB2y7/5100sAMbkDFRBC3af
         1Pn5M1NOvXRgQRdFSvNd9co/c+ruIMEfqA3eLSUEppGj5kp75CQeK7qSL3Ihn3RTV2oT
         V7kNRFOiJxn5uzKSAFyASfDFNgMelnUJ/7VFpnHn0p5yW91ARf1OnBBPYjiKAga36h7n
         oQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543163; x=1796147963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pcVobQ6pdsPePLIZ/BBz4G2XF5J7pWqm1D1h7L58vTo=;
        b=W5Fgd695ZnKRBAkhyC7TqyjmXaIS/uw0W1JRddhVb4Ehzf4dpihcNEICJq/1zAgU5X
         WYxbIIefyw1Yq1r5uIprc5U1OGW8u517dvgQtcgCofGBkbzXkHMhFGbPil+rtTajFd+4
         0Le3Ah4PTn5BX35d5eP+XWmHInqK/JlqtDyuSAUegTs6vJhaOuDjgHX8ZC/hvzviZFIC
         wFF5HW+dKnW+imolx2vZIaZGzMShQD5FZJfmvSMu5j3TamfccA+p8H8R2aCs04qjXamV
         hddaLa3drROjJHv1qtLwsdSc83VDd9NyreC3yrBpBVEDdPwWGE6d5vb97iF/se9E+eAx
         ewjA==
X-Forwarded-Encrypted: i=1; AL+hErHWbwuFUmxNwXTg901Duu/gu1NpTW0usuDJ3fRZYa8JIGNrubjo4YxoQvTVgNmCUvR+AuA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nuXfEqKsRN9KnT+vzIQs78nlFXc0OJTUhSm6EAHbHdHyHc1WA
	HXG+5KNK4JVqqtgQep+4BD5CHJQ9UjnlCyaSEeMgRSb3UGHpucGyzQF3UNfQMfJYmSA=
X-Gm-Gg: AZFdTZcwYctemSZVsCKFAiz6MGTfx+ebXVdcB22tMSTTZ1cbyKy0OTMtub6r9zfViSL
	CFlhTqtcubxiE08YIy6XeDEET35E4AsS/wx9G24yfet+D/1Qyk6fm1I9JsqLV1pKaXGiuWie8xW
	SzDFUyFKiZYGkB5uqEK2QED0F6zYfbm9d4Aj5kzsBs/5DNDZ8EAAuw2BHh8ecUCMJ/nifrEh41Q
	6SMyej+/SFsaOZ3z72WEyi7i/+nzO4yNBMnawAXfxMUN2z/lvsC6tMMfCOUO0r6eoR3rzDzF8/k
	1xoXCTmsuPaFuP+7Xoc7j3LE/QO00iJnMxabO47V0k1iZtSeLkT+0PgXkpRF+vRP7pdr7+z9GV5
	nmG8+Rz2guId72ykgJ1rLPJQI2ICbR11j+pXikPfwmv79lNLym9jFQ96dkBkvApfpJoweQIabh1
	XlOoYtGcacG/23IIv6Agsmuz9qf4/Klqc6Aq1tYpuryCUHI4UULF8C5sLnWPsaJt/5i3esmMALv
	DQ6ZXUo8wBvvuxnL9csI/xTs7xa8R86Kpu7vLXOfCKWWUsWsgOYk76gHMIvRTL/DZhkpZnNW9wG
	r46cUc2BrRXz5ObUFjmX1dgRnM/QBODFTAcvqE2UPPL46hI=
X-Received: by 2002:a05:6402:cc4e:b0:6b9:278a:99e7 with SMTP id 4fb4d7f45d1cf-6ba37d62527mr9133559a12.7.1795543163573;
        Tue, 24 Nov 2026 09:59:23 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba3711ad52sm7205762a12.35.2026.11.24.09.59.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 09:59:22 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Keogh <dkeogh@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Danielle Ratson <danieller@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	nh-open-source@amazon.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Anil Kaushik <anilkaushikwireless@gmail.com>,
	Demos Ra <demosthenes.ra@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Joe Damato <joe@dama.to>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Li RongQing <lirongqing@baidu.com>,
	Louis Scalbert <louis.scalbert@6wind.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Song Liu <song@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Wang Zhan <wang.zhan@smartx.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Zhou Qiuyue <n0ps1edzz@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>,
	Tianyi Gao <tianyi.gao@linux.dev>,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v3 08/11] selftests/bpf: Test the tx_extra_headroom decl tag
Date: Tue, 24 Nov 2026 17:58:21 +0000
Message-ID: <20261124175824.60470-9-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124175824.60470-1-tianyi@cloudflare.com>
References: <20261124175824.60470-1-tianyi@cloudflare.com>
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

Check that the verifier accepts a "tx_extra_headroom:" tag of
NETDEV_TX_EXTRA_HEADROOM_MAX (512 bytes), and rejects a tag above it, a
tag with a plus sign and two tags on the same program.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
v2:
- New patch.
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_tx_extra_headroom.c    | 40 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_tx_extra_headroom.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 6a494c381266..e3ef97ed092a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -126,6 +126,7 @@
 #include "verifier_subreg.skel.h"
 #include "verifier_tailcall.skel.h"
 #include "verifier_tailcall_jit.skel.h"
+#include "verifier_tx_extra_headroom.skel.h"
 #include "verifier_typedef.skel.h"
 #include "verifier_uninit.skel.h"
 #include "verifier_unpriv.skel.h"
@@ -316,6 +317,7 @@ void test_verifier_subprog_topo(void)        { RUN(verifier_subprog_topo); }
 void test_verifier_subreg(void)               { RUN(verifier_subreg); }
 void test_verifier_tailcall(void)             { RUN(verifier_tailcall); }
 void test_verifier_tailcall_jit(void)         { RUN(verifier_tailcall_jit); }
+void test_verifier_tx_extra_headroom(void)    { RUN(verifier_tx_extra_headroom); }
 void test_verifier_typedef(void)              { RUN(verifier_typedef); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_unpriv(void)               { RUN(verifier_unpriv); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_tx_extra_headroom.c b/tools/testing/selftests/bpf/progs/verifier_tx_extra_headroom.c
new file mode 100644
index 000000000000..f15963e34434
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_tx_extra_headroom.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("tc")
+__attribute__((btf_decl_tag("tx_extra_headroom:512")))
+__success
+int tag_max(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+__attribute__((btf_decl_tag("tx_extra_headroom:513")))
+__failure __msg("invalid tx_extra_headroom tag '513'")
+int tag_above_max(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+__attribute__((btf_decl_tag("tx_extra_headroom:+20")))
+__failure __msg("invalid tx_extra_headroom tag '+20'")
+int tag_plus_sign(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+__attribute__((btf_decl_tag("tx_extra_headroom:20")))
+__attribute__((btf_decl_tag("tx_extra_headroom:30")))
+__failure __msg("multiple tx_extra_headroom tags for main subprog")
+int tag_twice(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.56.0

