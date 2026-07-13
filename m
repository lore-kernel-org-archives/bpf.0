Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD73203B4;
	Mon, 13 Jul 2026 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910955; cv=none; b=Kim31t4V/e9WrU8eGF44mzktAFSLUjuCFh/jvQOCzOrRMl+igzQW2HM/8AHityEW4+gFkUQ0E3LrqH9jCxQ4uibetLk2iiLxyEqfFifuOmxIPkRpcq1WtbhtZshKz2eqtx5scM6LFK9MnBJFSb5n78DjWRCPxQgskw2DDKMv6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910955; c=relaxed/simple;
	bh=mWp/nM0Gh8Wixp6deMbe3pVOvz+ovyAoQM85o64mwO8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=B6JrQ2y6foZrC6/X7p6XhbtGAg1MuUBaTWspTKScI3NL27WD01hGUyFN2LIXGcRsQRGQHlO+0fLU0IVciMz1walp7+Us1am7EV51/EiVoP5w1oCffZ/SxeSEItM9WrDIihgHfiGbzBh7kx1h1p0u9yTBY/6Kok9GYkVtgzKiVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=YWO7ad9C; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="YWO7ad9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1783910944;
	bh=TQKEG5eyBlza3ylZjSY96RTCw81tW+xsMA0G3tWvFVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YWO7ad9CGVCm5dSDk0ksjyYdPvVykp/3BpuC1tjwQJAJtLvBVGd6UQb4BnCXupScf
	 O8uCaRe8a7SIj7cF4y1Eg+UUEL+KhLjyjKCSVSQsAhecBb3xsB0r5cC1gzei0Rhi1G
	 uoixPqYbtNfSIKDnPj8r2LV097kwPQi/fjQ+MZvY=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id C419D8BD; Mon, 13 Jul 2026 10:49:01 +0800
X-QQ-mid: xmsmtpt1783910941tvwli3g4p
Message-ID: <tencent_22134645443B75ED907D2A85A47AD554A709@qq.com>
X-QQ-XMAILINFO: NSObNE1Kae7ZGjGCbfCS5/kSrRPBU1pF2p2ioEZK6hUvcOG6XEpZMQh0mFsEF9
	 DGkAx0qqzGPw1f9H9oAENefL5MYSozXnPYtJOxcfeyx3GHWmjO66YBGH9IyrFDPL1vgBrbwN3GEI
	 ZxmQyJDpaQbMfN4cJwbUlCd8/hsPELq7XWFmdN/oVRFnItOb4Yr5y2ukt1F9SV2hs6s8cvPaq5kI
	 DcZazL7+HcpJKGy6/bHmEk2L27Hcx9Wkq2OuIuLTCIwEsHUUcD8H/ALHdNSGkv9I1UnvD9IdYhiI
	 Id5xXl/DMCEA7N2RzApwwVV0XcUvxSKvRegViiqID1yWmEluMPFv0OFy5bhbGRPgpPL5k+FNm8X9
	 yTlNO7TkCZzt41PGGkPPZ7hxVNm/5kXvzf1fTotnsDdrZmoocLZycnAYadUhwm3J1zysR9LEsOv6
	 sV3mJ3/VG0/57/qFa/9E0VWJWg0G4+8RShzNUoriX5yxvEEqVE+fLWAyptZfHQnzaqI3TYL3AxpG
	 KNF4bsqwX5Z5M4N28qj6U8joqOgb8gyhpx36Ephw8K/DaGrmnMxdW5nS9JEM9L8Cy5ginmXWU9Ci
	 DbaP3UewQNNmcrUSrjCc4GKaPGivAE8SBFdMWKiXS4iILS5Aumg932FajJIo4T5IqbDvsugO56+n
	 bbc4JDGjxnkNRT9M/RoaWQ3XRSCGxZzzeFGO2Tqo3EdMQqfbj8rMH7em3UueUjk9Wv87/0iXd7Lj
	 ZBkAX8RSEFHdbVdS8w5TAdeRsVBSQe6qZUpbL7PT/G232gfn3MxR8l1bv5zNUTkR/ax5mxFjS6O0
	 gTfaEwOBT7M2kmE0HHy2dvtxvErG8NS6kMbb7X5vM54tV2UdNlvDRoZpQibJyhBA4Vcdcto3QYDy
	 SiWKBOGzgzDacyD+fXe1aGZt+43xT0Ag7brpkaOEP5XsTPcS+4GO9nY0gS8i8jCjfLkk2sRtpeTI
	 fVNQTUTyA/U9P7enWMtUqUH9/IZ3wvCxSu3afvpxB4y8ubVRC6CIzaZrNWxOa9tUuW0idMXOPrAg
	 PDzawpdpcvnpG0K/EbELDsKFo+58ViLyzcptCmyEYgnAGaVZyuR4cqepCezc4WStgCyws4FQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: bpf: document BPF_RB_OVERWRITE_POS in bpf_ringbuf_query
Date: Mon, 13 Jul 2026 10:49:01 +0800
X-OQ-MSGID: <20260713024901.1922919-1-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713013856.1743009-1-shijianlin11@foxmail.com>
References: <20260713013856.1743009-1-shijianlin11@foxmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_RB_OVERWRITE_POS is supported by bpf_ringbuf_query() but was missing
from the helper documentation. Add it to the flags list in both the
kernel UAPI header and its tools/ mirror.

Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 include/uapi/linux/bpf.h       | 1 +
 tools/include/uapi/linux/bpf.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8d400b76..fe2873f6c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4664,6 +4664,7 @@ union bpf_attr {
  *		* **BPF_RB_RING_SIZE**: The size of ring buffer.
  *		* **BPF_RB_CONS_POS**: Consumer position (can wrap around).
  *		* **BPF_RB_PROD_POS**: Producer(s) position (can wrap around).
+ *		* **BPF_RB_OVERWRITE_POS**: Overwrite position (can wrap around).
  *
  *		Data returned is just a momentary snapshot of actual values
  *		and could be inaccurate, so this facility should be used to
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5e38b4887..7b024da3d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4664,6 +4664,7 @@ union bpf_attr {
  *		* **BPF_RB_RING_SIZE**: The size of ring buffer.
  *		* **BPF_RB_CONS_POS**: Consumer position (can wrap around).
  *		* **BPF_RB_PROD_POS**: Producer(s) position (can wrap around).
+ *		* **BPF_RB_OVERWRITE_POS**: Overwrite position (can wrap around).
  *
  *		Data returned is just a momentary snapshot of actual values
  *		and could be inaccurate, so this facility should be used to
-- 
2.43.0

