Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F543FC5CC
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534989; cv=none; b=qkGgEMEmYlko41fajnqZpcUqI/sa5JnN/wQraf5zyhkjFeONZpieS4L3ZfZ8xTiOAhq4ptmP03cswZvRNh31kzHpHafanNdrS0qbj76NfVbsoHajnfnFdnAzzb54w/tdrcfh4QF9+nOlWOWcg01CrnZ1sDSgRar0PjngHTus/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534989; c=relaxed/simple;
	bh=M4h1wTz5N5UW8zDktTjCjKJcoo4qbIQ0VnLMdLdU3pA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=DwZCCXLeBybW3JTRMwfwzdYrr5SbtmaSlVSB5Ae/UHPA5kYLouIpt7v8F18mub6z3WAV4Q8qZNzWxitGuLgbR7uaztEPGEZiu+1C8bclyzIthP1b6FmWPAE0bWDAL71+9T6Cb8rHakT/mqq9XcMU5ShLgezZ+xf5t3qBhMPR28s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.196.136.25])
	by mtasvr (Coremail) with SMTP id _____wBHLQABETBqX06kAg--.9355S3;
	Mon, 15 Jun 2026 22:49:38 +0800 (CST)
Received: from ziye$zju.edu.cn ( [10.196.136.25] ) by ajax-webmail-mail-app1
 (Coremail) ; Mon, 15 Jun 2026 22:49:37 +0800 (GMT+08:00)
Date: Mon, 15 Jun 2026 22:49:37 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5pu55aSp6LWQ?= <ziye@zju.edu.cn>
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	tangyazhou518@outlook.com, shenghaoyuan0928@163.com
Subject: Re: [PATCH bpf-next v2 1/2] bpf: support shift operations with
 non-const src operand
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2026 www.mailtech.cn zju.edu.cn
In-Reply-To: <ac5b73c3-f886-404a-a608-29aca3782274@linux.dev>
References: <20260612121041.25254-1-ziye@zju.edu.cn>
 <20260612121041.25254-2-ziye@zju.edu.cn>
 <ac5b73c3-f886-404a-a608-29aca3782274@linux.dev>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7681d974.1689d.19ecbc26c0f.Coremail.ziye@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:yy_KCgBna6UBETBqjRH8AQ--.28793W
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/1tbiAhMDA2ovBBIjJAABsE
X-CM-DELIVERINFO: =?B?fGqBpwXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083j6ToKl9cyaTORebfNb2KBjBBbGMORSuAcl5FiRZAPt2GtdeNC6T4l6YWEB3zbvwUCuo
	FEGqzJl/yjNqYtKXaJJrJ83tg6q2R02qdGr4l3JFBmPlkdlxiJuO07rc552Skw==
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUQYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280
	aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48Icx
	kI7VAKI48G6xCjnVAKz4kxM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2Iq
	xwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFcxC0V
	AYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IU8rcTJUUUUU==

T24gNi8xMi8yNiA1OjEwLCBZb25naG9uZyBTb25nIHdyb3RlOgo+IERvIHlvdSBhY3R1YWxseSBo
YXZlIHJlYWwgdXNlIGNhc2VzIGZvciB0aGlzIG5vbi1jb25zdCBzaGlmdD8KPiBDb21taXQgNDRm
ZGQ1ODFkMjczICgiYnBmOiBBZGQgcmFuZ2UgdHJhY2tpbmcgZm9yIEJQRl9ESVYgYW5kIEJQRl9N
T0QiKQo+IHN1cHBvcnRzIHJhbmdlIHRyYWNraW5nIGZvciBkaXYvbW9kIGJ1dCB0aGUgZGl2aXNv
ciBhbmQgbW9kdWx1cwo+IG5lZWRzIHRvIGJlIGNvbnN0YW50LgpObyByZWFsIHVzZSBjYXNlIGZv
ciBub24tY29uc3Qgc2hpZnQgYXQgdGhlIG1vbWVudC4gV2UgaW1wbGVtZW50ZWQKdGhpcyBhbmFs
eXNpcyBiZWNhdXNlIGl0IGlzIHJlbGF0aXZlbHkgc2ltcGxlLiBJbiBjb250cmFzdCwgYQpzb3Vu
ZCBib3VuZCBmb3Igbm9uLWNvbnN0IGRpdi9tb2Qgd291bGQgcmVxdWlyZSBtb3JlIGludm9sdmVk
CmxvZ2ljLCB0aGF0J3Mgd2h5IHRoZSBwYXRoIGlzIHN0aWxsIHJlc3RyaWN0ZWQgdG8gYSBjb25z
dGFudApkaXZpc29yLgoKCgo=

