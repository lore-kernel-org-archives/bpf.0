Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E84AF165
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390494; cv=none; b=qqKEvGP9hrGwbL9COxFo5O/RXI+LYZ3AGXA4DgtaVPWo1sIe/Cv1PVAPq1QZfCXy3o9z8JjWuUWm/RsPm2wJSXxffarcnCBZauwCMKoDG8Ef7JGthuNqoXCbbo+O+ZpZU3Uty4wQ3XZ2ZNziJW4SCtIKU63GlrGh2wUmhSitwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390494; c=relaxed/simple;
	bh=g24tLA/3dhshJtjhfImC89zVIL2/mIHY6gHdvT9uvno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuQRIHS9hWIlXkVZklbCNUAXnjd3s/WsdQ5BcycmFdOQ0JT/vub1Dwj1lvMyOc/uJOgBgwLitd1flTOjHjv1ZCCJ76uzvW72zi3awk/wwpVL+jbKzRB1ZbsqDS/bt9QqOK+YxCWJgwR2pnHyREWdizG09D+MAug3KJCMRrTK/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXIf6UE7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXIf6UE7"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-486e8faff03so1109071f8f.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791390491; x=1791995291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wITKzh5wW1j9YD2B+DIVbeYkbAtDPNXFE+j076Iz2Dc=;
        b=aXIf6UE7BhCgHZ1CEe9HcqHdhvgW5ungWcr7UBRY+VvRh643aiNNl8BGbexkX/2YtT
         Iowx1V6a9EnPqR5/9LyNXDdOI/C7SVlJeZKEyBkABL04x+DihAOkzmRLXQ/1eKmraLo2
         G6qPchi10aa99XqRP2xmC0mOmodVcOmEXGdUFCpLnTh3luq2ZcNcSILfkhI1VkhFsjD4
         wLkoJHFQ/vMlVOFkqsDnJlrWo0CrmgmX5HAwRMheLQKe0LagV83Hw2LzaJqgtu+KdrK4
         KBf4KqSRseQObI9NQRshibiKqSfXzaTMSINbGUH3v1Ifb3m/848GJbnGOHr2N2OBG7Gk
         SDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791390491; x=1791995291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wITKzh5wW1j9YD2B+DIVbeYkbAtDPNXFE+j076Iz2Dc=;
        b=XSG7BwhvtWqjImy1mmpIwmLCwRs9KRyl3gnAf5X7DDV+JS8ZdIMUtvWJIFzglx0IhT
         NOl/zBDo2k6OYz4oRfk570LVzhTG4kQeUfRt3dVVkGdhbHR62OiY0jvZPGOZe8bRgO70
         Jn19DLNO+u63K0MIoMpu9MsPeYvlsa8DFONcYn92wxjfJEdMOri9HZcaWJZIKjWfI30m
         BMefMlRIqxS/X5z30sffAkBRnnUmzuliIvBf9YPBVzlVsEqW+/lBJ2ClH1Ucc6VXyZR9
         /pewawVb9QwRFmxZb/DLzr5D3rxjEBx1TzuZmaSV8S3Crej5lgbtqahFiaHjEnrsLYdw
         t6kw==
X-Forwarded-Encrypted: i=1; AKwUvBynriwE6fWLFdBdofD+APhX0pV5R+9LAaHXmA6/lVxct/c7teShn9UVcJudTOSVQ4x3emg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYYAUWRnUpSlWMgCNMmshfwTBgSw7074sXL9Vu96eZFkjan9+E
	KzEPC2wdZVY9c2sjBYktIrZ5AFLWdaO3UvzOgbADY/xDrkcpSktf3EY=
X-Gm-Gg: AYBFou1CBLpsqxndyy6EdlNJ3li+jA//VlYJo/xmSP5yEXINztLmm30GogbwSz7jXpp
	WUE2YHW0diAWKCkJ40umEh0lNLLaTKMrymY7966/bd8cBbdiwcrdJacPTFXfxv7M5EhMgQUn3xm
	xPYRkZ2ERa88JPoNXMIU0QNCHibOC99uPRoUB5bPzEO4JmsHaKEqlO5WHUymqHutgdX+yhe6jjV
	CxsoLk1mrqvYLav0MVeHhmJVNLGToqF1PkErux7/tTbW8Z+Ysjx6Zk4+TVDpFfes7PbdE4AeqM7
	MFZ6Y4KY+21V0bj7ZwY+oAQwnFUTp0iu5MPncM76qKiTrror1+QbbSXr7Fgzjso8fk2uJZMnZgX
	h+37icrTR1NrilpNK7B7PVXZqUdN7KWYwKTSV8uUeW1yec2EPFodDc8V3omf+Y4+SszkEI7bX4B
	+f3bkahOZXtEi57977vg8tOfKamniBv60HNwhp7IY=
X-Received: by 2002:a5d:5284:0:b0:48a:ef5c:fc2c with SMTP id ffacd0b85a97d-48c7278da82mr4164015f8f.48.1791390490777;
        Wed, 07 Oct 2026 09:28:10 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d13a01sm6697451f8f.29.2026.10.07.09.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 09:28:09 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2] HID: core: fix device cleanup on allocation failure
Date: Wed,  7 Oct 2026 16:28:08 +0000
Message-ID: <20261007162808.373024-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904080524.3872926-1-tristmd@gmail.com>
References: <20260904080524.3872926-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

hid_allocate_device() calls hid_destroy_device() in its error path when
hid_bpf_device_init() fails.  hid_destroy_device() invokes
hid_bpf_destroy_device(), which calls synchronize_srcu() and
cleanup_srcu_struct() on the SRCU structure.  However,
hid_bpf_device_init() returns the result of init_srcu_struct(), so
when it fails, init_srcu_struct() was called but did not succeed and
its failure path rolled the SRCU internal pointers back to NULL.
Dereferencing them causes a general protection fault.

Use put_device() directly in the error path to release the device
without invoking SRCU cleanup on the failed state.

Fixes: 6cd735f0e57a ("HID: bpf: protect HID-BPF prog_list access by a SRCU")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---

Changes since v1:
  - Updated commit message to clarify that init_srcu_struct() was called
    but failed (rolled pointers back to NULL), not that it was never called.
  - Updated code comment to match.
  Per bpf-ci bot review feedback.
 drivers/hid/hid-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a3ff0514f9cdf..7d1b781c6debf 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -3115,7 +3115,11 @@ struct hid_device *hid_allocate_device(void)
 	return hdev;
 
 out_err:
-	hid_destroy_device(hdev);
+	/* init_srcu_struct() was called but failed; the SRCU struct
+	 * is not usable.  Skip hid_destroy_device() which would call
+	 * cleanup_srcu_struct() on the failed state.
+	 */
+	put_device(&hdev->dev);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(hid_allocate_device);
-- 
2.47.3

