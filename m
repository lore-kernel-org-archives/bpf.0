Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CECBA21;
	Mon, 16 Mar 2026 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669171; cv=none; b=QNgyYYTwbfBTJ9OtpAEQvXX9kyYaYO3k4oF18ruowh2SdSi1qJeYks2DZ8LzjwT2uGQn0w9JM9Xyrhj1IsXXvc7DGfsibFS6VVSwUYsYMgi4kSL3i28WZM4u3MhuxK8a+4GxECVI6ytqCwvEeouHL15CK3OqIM6kaSuMoBPmHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669171; c=relaxed/simple;
	bh=RdDJalH/fogGxbxxcKkLHnxdU8FhKFFBzboUhRrUXNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8Ue9yvOOjUjgyUtxwi95nX85FJQWhRNib90JlcwPy1XYTB5zMHrOe35oo/lkkZeb8o4lKPXhvk9JwQhNAXcnxOdhRT8j5o/O8KDeIKRH43qhjwPNWAQ0CcMPpXue0sy4B6xQhAItWwQ0ZmvyV/mcZdbus3MipxmsZpHIEGk7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GfUwLmAA; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GfUwLmAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1773669130;
	bh=/5fzZ7ip5culErJUozUqvEwptDYuVVndbhx2Gz3XeIk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GfUwLmAAJMhwbZge42iXCd5lxfvDC9w0hVb2P74c9Kd6Vf65NgXroAk+aGCw9SgZU
	 7REbNVQygESoX0WevWgcu94On4XFTTtCPZHH5Oyg9VygqG0hl2QsqSa5pGs78oo7VZ
	 AEtK4is91ZlYYCApefU5+Wpb5BEnSCa06jEQCkTU=
X-QQ-mid: zesmtpip4t1773669124t516cfaa0
X-QQ-Originating-IP: 1Oni74ju8vtGuWxxzSw/Il2KMUqqapxFokvYokZIDEY=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Mar 2026 21:52:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16117058688590752373
EX-QQ-RecipientCnt: 20
From: xulang <xulang@uniontech.com>
To: martin.lau@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dzm91@hust.edu.cn,
	eddyz87@gmail.com,
	haoluo@google.com,
	huyinhao@hust.edu.cn,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kaiyanm@hust.edu.cn,
	kernel@uniontech.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	paul.chaignon@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	xulang@uniontech.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf v1] bpf: Fix OOB in bpf_obj_memcpy for cgroup storage
Date: Mon, 16 Mar 2026 21:51:59 +0800
Message-ID: <D3B60D7890B13875+reply-to-v1-review@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <db2e04a2-3cf4-40f3-85ef-14197148d027@linux.dev>
References: <db2e04a2-3cf4-40f3-85ef-14197148d027@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M6W1gzdQR5sqZTOFKvRfOgSKwobLv4q4lweMmHcCcYI3C3iUaOcVcW1+
	Xq3OhV+TxONIs+vHpIyb45CXAXyfINedzLEyXMvXf6hYhM43tU7lblW+U1AbpdK+ULew+lr
	694i4TQ7WY9CTD9UMLwAVxqgqNjfV76NT3UQHJ4CIZvikF7PVYabLTU8e+BjFsoZCnl3z2c
	6lzQQgeE5W+zattVDc1aAnkxAG0p01HBT4ThBAqywRhwgmmtDQnnbZJxLu0L2CGUJ0RRTjC
	5vxlf7AnccuaI9MXzYjtO5eEaN5ancNm57ppSmazNnfbYHNGNYf5F4k7ODjupL4gQU4ywic
	uqKNWb9vQLT8USEGZONP5ojrNSRAhPa2/JeV7x1BMg21tx4yoMuE2kYW6uHeDk5lWl8rj4b
	GPrgb8ZR7oSxms5XrkS/QXRi0FDLdi1532HY34rVFj8dwH8sxd+O2sFSeplcXz9YTQvN6Qm
	rOtJ0OYlNoLhQaomwvu9cjhCCCCOTRj0wo18ahixDg+A6CpiLODzIYZ2Q1CsAN/QPQ3zww/
	YAY/YvBzivnUypbmXMsXOfk1BSMUr2q8KOQr89oi6Z+lCVQ0dQAMsFOo90kHAMWvPXFfpO6
	m7liAqHbZqRhxa2UiLTQA0fbMbVD6bt27vvxNCfwUqPYoi3tpIlQO2vFykisrAdSPJm+F2e
	/v4HEnAVrPXps0UhL+7S6x6gYMUBGxxCL/JFleWIaOzj1KUNL5xsHs3OZmio1PmnWt2rffw
	YpLAbIfvGcVg8tkd6SA5eAilEMlSiC+Ump6uz2bcyokXA0NFv/9k4Dn6aSnMtCy5byrE6Xd
	895vDDqFrLMcH+OF/jDmQcYcpmN+QKowa1P6ZIuOsTUMOY7eB7owTAmKtG7pHXBWCjz5srT
	Dt0RUZU3JPfwXyWs0OyAObdF2PGtk7wNm68T0KqMdN+fWWPoHBplie+x4uhUlWqIhShcZ8G
	Nvlvn+cYFDMx2l8yD88+Z3BEPowTwTgwlGsGLIHW+D4UZz/9y03sdeLZKBt1Swgu/ZTQb1W
	qLtUjuNmwwLr+UDjiQ6h76b+h6ZCk=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

From: Lang Xu <xulang@uniontech.com>

> Please create a selftest for this.

Going to do that. To stably reproduce this bug, I need the KASAN
config enabled, how do I ensure it's enabled during a selftest cycle,
by adding the line below to the 'config'? not quite sure.

--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -46,6 +46,7 @@ CONFIG_IPV6_GRE=y
 CONFIG_IPV6_SEG6_BPF=y
 CONFIG_IPV6_SIT=y
 CONFIG_IPV6_TUNNEL=y
+CONFIG_KASAN=y
 CONFIG_KEYS=y
 CONFIG_LIRC=y
 CONFIG_LWTUNNEL=y

> This is fixing the src side of the "copy_map_value_long(map, dst, src)".
> The src could also be from a skb? What is the value_size that the
> verifier is checking for bpf_map_update_elem?

The value_size checked by verifier is exactly the size with which
the map is defined, i.e., not the size rounded up to 8-byte by kernel

As for bpf_map_update_elem->..->copy_map_value_long, 'src' couldn't be from
'skb' which mismatches the expected ptr-type of 'bpf_map_update_elem',
I've tried codes like these:

1. bpf_map_update_elem(&lru_map, &key, skb, BPF_ANY);
2. bpf_map_update_elem(&lru_map, &key, skb->sk, BPF_ANY);  // null checked
3. bpf_map_update_elem(&lru_map, &key, skb->flow_keys, BPF_ANY);

All these ptrs mismatch the expected ptr-type, which can be detected by the verifier.
The verifier complains with msg like 'R3 type=ctx expected=fp, pkt, pkt_meta, map_key,
map_value, mem, ringbuf_mem, buf, trusted_ptr'
