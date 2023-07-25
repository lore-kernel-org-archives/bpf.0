Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5EA8BE5
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 05:41:22 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DAD199F
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 22:41:12 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 72CEA239E3DD2; Mon, 24 Jul 2023 22:41:00 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3] MAINTAINERS: Replace my email address
Date: Mon, 24 Jul 2023 22:41:00 -0700
Message-Id: <20230725054100.1013421-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
	SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Switch from corporate email address to linux.dev address.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Changelog:
  v1 -> v2:
   - Use new address as the Signed-off-by address.
  v2 -> v3:
   - Use new address for the 'From'.=20

diff --git a/MAINTAINERS b/MAINTAINERS
index 990e3fce753c..b170081d6c3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3703,7 +3703,7 @@ M:	Daniel Borkmann <daniel@iogearbox.net>
 M:	Andrii Nakryiko <andrii@kernel.org>
 R:	Martin KaFai Lau <martin.lau@linux.dev>
 R:	Song Liu <song@kernel.org>
-R:	Yonghong Song <yhs@fb.com>
+R:	Yonghong Song <yonghong.song@linux.dev>
 R:	John Fastabend <john.fastabend@gmail.com>
 R:	KP Singh <kpsingh@kernel.org>
 R:	Stanislav Fomichev <sdf@google.com>
@@ -3742,7 +3742,7 @@ F:	tools/lib/bpf/
 F:	tools/testing/selftests/bpf/
=20
 BPF [ITERATOR]
-M:	Yonghong Song <yhs@fb.com>
+M:	Yonghong Song <yonghong.song@linux.dev>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	kernel/bpf/*iter.c
--=20
2.34.1

