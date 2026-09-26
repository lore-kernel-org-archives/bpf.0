Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D8315D53
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790441657; cv=none; b=dPNLA1ZgvPYBwyR4ORgde/4OumhkK4Y53B1xYqa28DdWCgs8IMcZsuhhk3FrNiCgbRYWtjrGYHouVdw0YJyWstN5WV7Js3UHsndq1ecPtVXxhmhPI0unOH7okXBqZx7JBEWaZoS38385lUXmRvwI5NVq9jx9nIERLrZlXRFDgyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790441657; c=relaxed/simple;
	bh=Gw7QnZKpBAInhCbrAFF2+t/4WB9RHd2d4KQYsebetzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FL3VnoySxc7zVt5SjVcarwfrskB+tUaTcW9V7WdvwJa6IwKQD0CATamqgq5o12/FLWmWpWIop1rITBwDnK9TOQkN19ojBbnHYfeR0olmbP/MKqaXTPxAqsXrDtvPHszMXvTRNBT1EyAUOXay0Z+SPCa8QEylIRT71G51XBJWtH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT4RCa26; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT4RCa26"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so10094495e9.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 09:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790441654; x=1791046454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=43SfXFeCUVog3VRlWez7W16wV/mBtSGE4lD//NBDZ+8=;
        b=GT4RCa26plRxKHtwVEjs6k12q9/4C6CYUQI4dBvdYMV+RCvLunO7RUO49kxNXQUzPv
         Qm1CpEJGzsukNcfuRJ0p/B7UslP38/NBYsdBO9nzZj9/WuWSA8MSAQbaEbsrlU0aBPs0
         4S6IzS+4E9ZL1tJRKuBpyHZI645KpR7jD3uaekdcCcuwXSoqrjUSiZBUWn9KuT1TTwa7
         nT1otMfGSEAeE+D5uxe7D1/2jfO37PsU5bmWjecI9VQZMUbNwA2t6llrMwct6edDjz3M
         YG1u6p0091uRHpwJ0EVdg68dacKkuw9LZoeYhrxEkaiPD3AJS5QPkvmZVKXB0N85K5yf
         CNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790441654; x=1791046454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=43SfXFeCUVog3VRlWez7W16wV/mBtSGE4lD//NBDZ+8=;
        b=SODyteQlxUBF7xWgBBTXFnJH+NbRoeKZcZlS+cWHwPnILbS/pNWr4zO2I+D9A6tK3/
         GBySV2Coynr3lYM+12IzMOiP/zGa7x+EKF5QTv+F0vFVRiNnUpBRP+N/RC4I0DrmWiPB
         hSABU3kWCwqR1/o1UfUOT6r4nko9T9gqal7oi2qc/x5drNSxEE/Z37aNuAi6e1gg8HfS
         MVcPVtk2q6nD8iVqVJYxXqM8bHz/dwKHLhy6SrlLea/Ek9tKQNWI6hlupxsJzscZbwjw
         tQ3Fpimtjq9w69TLTMaUbsLrAP+1MxaBUJ5vFjLoppMnu6DzxSh/I7s95ui9GG6Mv/CY
         W++g==
X-Forwarded-Encrypted: i=1; AKwUvByfApnnPAUNvgkoKeviSi8C9jAwkp/Qt+7ajq3b8UHWNnhbyB1lXKdrrvLHo9DsmyxLssg=@vger.kernel.org
X-Gm-Message-State: AFuF++nzuhAfm1JQSMaWTi/elY5pvdkF//+26bkLX30lh01Vl22wPmEP
	VyzSDMVlTD+KPu7NAqziz7ZkKkBnDj2COS8uQrD70Jrw6vCTYxfLVUpo
X-Gm-Gg: AYBFou3cklxRR/cn+xl9pYeHeY/3FxqT3Kx3+1PbdZuzMNV4jGpBeKuFNlxMES3tOyn
	ijB9/EZiby+Ly6/7FCB5fq+BxRXEwETFBxHeqBibXusgdw+tUD6NyZfznZNTXKgAaFjuVUW3cIJ
	03xoi7kgp+rJnPqXcfVyqZMsSRzYh5jEbmzgCs1IjG7lLEsjigQwLebHnnotVmJ4WnmEYL2uk9O
	Q8qbF2y0KO1WzSgvI8TCWO/7y2Sav11r2NA57J2qMKyPZdT14BoIQmazinDV787gKuyJk1/Le30
	g4zd+vXsucuUhCOlXSLr8EEYLLMkG/rIwnMigfIZo3mbHU8j7xSMf7hcRw8rm2QBXz8V0yfnGEW
	txMExKpNoejDl/rl3QT2HFh/HBQz2HZKQvyAAlkGZ8N20J+cw/obEe3VTSfm3vQrB+9gcY55An0
	+EmASoo0IU2tq4/S2qvic1PuTI0Jlow+9vMQR99i7Ir3VxzbUyv5EEO8XQ2Lt+xL34WjRtYfTcp
	vIyZme7JM4upxVNnaBEnuBl0CYh7xA3jkZKhQIehjOzp4qu1MUWTftE/vU1MFC+YZqJ9I8yZUe9
	+9bTuBSsnFraFsKTPA==
X-Received: by 2002:a05:600c:83c3:b0:49f:fdca:c348 with SMTP id 5b1f17b1804b1-49ffdcac594mr24845445e9.10.1790441654240;
        Sat, 26 Sep 2026 09:54:14 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff98666e8sm83974445e9.2.2026.09.26.09.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:54:12 -0700 (PDT)
From: prathameshdeshpande7@gmail.com
To: tariqt@nvidia.com
Cc: saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net] net/mlx5e: Fix AF_XDP TX timestamp teardown NULL dereference
Date: Sat, 26 Sep 2026 17:53:57 +0100
Message-ID: <20260926165402.5902-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>

During XSK TX queue teardown, outstanding descriptors are completed
without a CQE. If one requested a TX timestamp, the completion path
passes that NULL CQE to mlx5e_xsk_fill_timestamp(), which dereferences
it.

Return zero when no CQE is available, indicating that teardown did not
produce a TX timestamp.

Fixes: ec706a860eba ("net/mlx5e: Implement AF_XDP TX timestamp and checksum offload")

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 77ea51bfbaae..2cca20e1b9b7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -293,6 +293,9 @@ static u64 mlx5e_xsk_fill_timestamp(void *_priv)
 	struct mlx5e_xsk_tx_complete *priv = _priv;
 	u64 ts;
 
+	if (!priv->cqe)
+		return 0;
+
 	ts = get_cqe_ts(priv->cqe);
 
 	if (mlx5_is_real_time_rq(priv->cq->mdev) || mlx5_is_real_time_sq(priv->cq->mdev))
-- 
2.43.0

