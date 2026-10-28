Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198193;
	b=OizBXAR0j931zGt15OSZVUFPcB67dTX6dUQ9AxxtqHh1j6OyMrdfIpJG0KbbQXivDXVY
	 d7nCKPDzxIgkeWtDn4fKyqi9uTivra1xDgfL53oraR5feWWvSCvSybSDJJtwbUli0e1tZ
	 /k909su89ZSNBAEKW8u21GT20pxjCjr2/xoGAS5h/y8z2zCA0/3ha+L27uG3Z8TysSnPW
	 MAAyJyDl5m16Qu0hMVZGswSxFdqJxSi47IjSrzS/gqfmMQNoTCosDpxJyAHYu9fomHL7K
	 MeRR9Z7+yE0oj83TXfTJtoYxoI1s7cEEpIW/4bER0K/r11ey46SyOhEwP0UcBY+fIEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198193;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PcT0+HJt4AIMZb6gBPswYlvgccMyUGtbzK1Fgvd5FwA=;
	b=ZTd+MAcsUXv1Mj5hhqPd+IN4vPt1O5saD+4oKr/ZSCCSul5V/ysJweJh6nSjhQZB6keQ
	 SJCAC+64I+1h90T80R04Y9QiWwuCVEZxeGov+nFZg/cYoS0/wVbrgGaPloZIQiL/c+P7g
	 PmcVRTJawIMjUzL4hoXeIBruNgNWt4aWfzJlp95JXkuKuMlddRXvMVoNbWx8lLZQmU6r8
	 Xk9aHmOSc4ftsNmzbDHtPOlPiWNyzeLHoyrtoa+L8ds+cZDvIzOJABvAbZWNANgC3FDBo
	 R6XwlUa96yiO/rDEXCmJI1lAXNXEXEcVRM846HbiVbPqTFCfHoglLHGmWoDJZY3+PBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=voi7FoTR;
	arc=none smtp.remote-ip=91.218.175.179
Received: from mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A960A2607
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 14:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 012A960A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=voi7FoTR
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=STr4bk1MPotLTKZ8I84gx0Ckn3WdFhPnigFYBQlPse4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793198191; v=1; x=1793802991;
 b=voi7FoTRHeHoHs33PBUYVGkmkiZlPy9LxAZXIvt9N1Q/3u590zM2sE/pU5y8YXiVDB+0rYup
 QEDvlwITUqUxDKYdj/1lQV0RUX12un9pqkkx5Flcw6DbXKEydrr9HA5EjZELvQBF9qKxWS9fZx+
 l+FTkMCrKk8MkxYH+Q+ovTnc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cf893e257c020513;
	Wed, 28 Oct 2026 14:36:30 +0000
X-Mizu-Trace-ID: cf893e257c020513
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	josef@toxicopanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	linux-kselftest@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn,
	ameryhung@gmail.com,
	alexei.starovoitov@gmail.com
Subject: [PATCH 5/5] docs: cgroup-v2: document the iocost BPF cost model attachment
Date: Wed, 28 Oct 2026 22:35:34 +0800
Message-ID: <20261028143534.135968-6-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028143534.135968-1-cui.tao@linux.dev>
References: <20261028143534.135968-1-cui.tao@linux.dev>
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

From: Tao Cui <cuitao@kylinos.cn>

Document the BPF cost model attachment in the io.cost.model section
of the cgroup v2 documentation: attaching an iocost_model_ops
struct_ops to a device by its major:minor, the model=bpf readback
while attached (ctrl keeps describing the coefficients), the builtin
model coming back on detach, and ctrl writes never selecting a
model.  The device's line is populated by attaching too, and the
attachment paragraph is split into attaching, model selection and
detaching.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 Documentation/admin-guide/cgroup-v2.rst | 46 ++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 9e3c67b02ae2..fd274037a9df 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2056,8 +2056,9 @@ IO Interface Files
 	currently implements "io.weight" proportional control.  Lines
 	are keyed by $MAJ:$MIN device numbers and not ordered.  The
 	line for a given device is populated on the first write for
-	the device on "io.cost.qos" or "io.cost.model".  The following
-	nested keys are defined.
+	the device on "io.cost.qos" or "io.cost.model", or when a BPF
+	cost model is attached to it.  The following nested keys are
+	defined.
 
 	  ======	=====================================
 	  enable	Weight-based control enable
@@ -2111,13 +2112,41 @@ IO Interface Files
 	implements "io.weight" proportional control.  Lines are keyed
 	by $MAJ:$MIN device numbers and not ordered.  The line for a
 	given device is populated on the first write for the device on
-	"io.cost.qos" or "io.cost.model".  The following nested keys
-	are defined.
+	"io.cost.qos" or "io.cost.model", or when a BPF cost model is
+	attached to it.  The following nested keys are defined.
 
-	  =====		================================
+	  =====		==========================================
 	  ctrl		"auto" or "user"
-	  model		The cost model in use - "linear"
-	  =====		================================
+	  model		The cost model in use - "linear" or "bpf"
+	  =====		==========================================
+
+	When CONFIG_BLK_CGROUP_IOCOST_BPF is enabled, a BPF cost
+	model can be bound to a device by attaching an
+	"iocost_model_ops" struct_ops carrying the whole disk's
+	major:minor in its "dev" member (a partition's major:minor is
+	rejected).  Attaching creates the controller if needed, like
+	an io.cost.model write does, switches the device's pricing to
+	the model and populates the device's line in this file and in
+	"io.cost.qos" if it did not exist yet.  Attaching fails with
+	-EBUSY if the device already has a model attached.  The
+	attached model prices IOs only while the controller is
+	enabled through "io.cost.qos"; attaching does not enable it.
+
+	While a model is attached, "model" selects between it and the
+	builtin model: "model=bpf" switches to the attached model and
+	"model=linear" switches back to the builtin model, and neither
+	detaches the struct_ops.
+
+	Only detaching removes the model, after which "model=bpf"
+	fails and the device prices with the builtin model again.
+	Device removal ejects the attached model as well, while the
+	struct_ops link remains until userspace destroys it.  "ctrl"
+	accepts only "auto" and "user" and never selects a model.  It
+	keeps describing the builtin coefficients, which take effect
+	again when switched back.  The automatic profile stepping does
+	not switch profiles while the BPF model is in use; as with
+	user-set parameters, the profile selected from the device
+	class still applies.
 
 	When "ctrl" is "auto", the kernel may change all parameters
 	dynamically.  When "ctrl" is set to "user" or any other
@@ -2125,7 +2154,8 @@ IO Interface Files
 	automatic changes are disabled.
 
 	When "model" is "linear", the following model parameters are
-	defined.
+	defined.  They remain readable and writable while "model" is
+	"bpf" but take effect only after switching back to "linear".
 
 	  =============	========================================
 	  [r|w]bps	The maximum sequential IO throughput
-- 
2.43.0

