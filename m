Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF246AA9C;
	Wed, 30 Sep 2026 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757087; cv=none; b=Hqp+od1xGYtME+Cip+Nhfap3sjPW7bsqSAlQ0o36XINYy0avv2NJf3JUvDORo1KqtABSs6uhlVVWoHUaRfGIZrrtW5WUVuZEBgRxpgBLkuPnlSMYqE0ShWfBsR6KFijpXbWbXxeTYXYG65hqAl+CuZGI4HC3EdLlJ8Xr60HqHmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757087; c=relaxed/simple;
	bh=0N5IRsU01uephUc4fo1Lmoo2twgOIUy74XA6QkBN1rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b64Tvq2sxW2TWVcEvI+3nUeuZZEQzKep93pJjM8VDTixi2bbrtbYy/01W3TrC6/TLKs44LK3Lvs5MFZzbPsdx0710rR4XtenTsoR8Zp+FJhbN34QBU4wLTUWNDc3G80gdFHvV9tB55FlPum3ah+9XDt6g4mM5kyt7WlZggZkxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hvpCP2dmRzKHMcJ;
	Wed, 30 Sep 2026 16:30:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 68F9A40577;
	Wed, 30 Sep 2026 16:31:18 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDXpyrRyLxq8dflCA--.24306S5;
	Wed, 30 Sep 2026 16:31:17 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: Update qemu config for riscv64 in vmtest.sh
Date: Wed, 30 Sep 2026 08:35:21 +0000
Message-Id: <20260930083522.1914145-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930083522.1914145-1-pulehui@huaweicloud.com>
References: <20260930083522.1914145-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXpyrRyLxq8dflCA--.24306S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1UAF1DGF4UKrW3Xw18Zrb_yoW8uryrpw
	4kJryYk3sYg3W3ur1kArWj9FWrGrsavrW8Cw48Gw17Zw12yFy8Xr97Kw4Ut3Z3WFZYgrW5
	C34IgFyY93WkJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0pRl_MsUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

When running vmtest.sh on riscv64, the kernel panic at boot due to an
illegal instruction. This is because '-cpu rv64' only enables a baseline
set of riscv extensions, whereas the kernel or toolchain requires newer
extensions. Switch to '-cpu max' so qemu enables all supported
extensions, and bump the required qemu version accordingly.

Additionally, qemu's pmu emulation for riscv64 currently has issues,
causing perf_event_open-related tests to fail. Temporarily disable the
sscofpmf extension to bypass these failures for now, and will try to
investigate and address it later.

While at it, update the libbpf/ci branch in INDEX_URL from 'master' to
'main'.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/vmtest.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index e7e0b419a0b8..c4663cad74f5 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -35,11 +35,11 @@ aarch64)
 	ARCH="arm64"
 	;;
 riscv64)
-	# required qemu version v7.2.0+
+	# required qemu version v8.2.0+
 	QEMU_BINARY=qemu-system-riscv64
 	QEMU_CONSOLE="ttyS0,115200"
 	HOST_FLAGS=(-M virt -cpu host -enable-kvm -smp 8)
-	CROSS_FLAGS=(-M virt -cpu rv64,sscofpmf=true -smp 8)
+	CROSS_FLAGS=(-M virt -cpu max,sscofpmf=false -smp 8)
 	BZIMAGE="arch/riscv/boot/Image"
 	ARCH="riscv"
 	;;
@@ -65,7 +65,7 @@ OUTPUT_DIR="$HOME/.bpf_selftests"
 KCONFIG_REL_PATHS=("tools/testing/selftests/bpf/config"
 	"tools/testing/selftests/bpf/config.vm"
 	"tools/testing/selftests/bpf/config.${PLATFORM}")
-INDEX_URL="https://raw.githubusercontent.com/libbpf/ci/master/INDEX"
+INDEX_URL="https://raw.githubusercontent.com/libbpf/ci/main/INDEX"
 NUM_COMPILE_JOBS="$(nproc)"
 LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
 LOG_FILE="${LOG_FILE_BASE}.log"
-- 
2.34.1

