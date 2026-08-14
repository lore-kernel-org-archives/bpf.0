Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B640DB2A;
	Fri, 14 Aug 2026 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714260; cv=none; b=LD0YdRCj46KdwceiY4BhZTBcZwc/p+pTkc0+t2yYxLEcrAmA4S76v19UuLMN17tFceSn0yU8Y+iHsLWZh2f7jl1OW6UtpSWZfg1Yw+9Kpm/JUXska69nRO8eAGlskZ7MfAnNzBm7jjXSXwUEmcO0CsW1SkstWOtj6xmZfnJXsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714260; c=relaxed/simple;
	bh=9ULoTSGCVj/w+s39ZLBV0LbdXllfjePvvTAdFDJnusk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ILLlb2t7WATNzZZ40a8YAWIFtdBpiici0yqDhiYNb6ETm07WFRL63kg8sKs3o5pxKYENjbcAp3vK8xGqqwMqIB7u2Eub0Y0FFzdfIEsmnOhV0/eV9fpuW0wfKHw9fa9k4sEq1CjQB8CWh9cqvenR80Fau1mUQzCB/3Evu/NjgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lArKcp7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lArKcp7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BCA1F000E9;
	Fri, 14 Aug 2026 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786714258;
	bh=9ULoTSGCVj/w+s39ZLBV0LbdXllfjePvvTAdFDJnusk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lArKcp7ufCcFkX1+dBDqgXJRLMqZqJQCCvECQ4tEakzBSCsJUyfMMS4Hfz7qBGRVv
	 Y6Hkthek6RIbhMCH9gFeXyiDaigvLquUoERXxvjQysQy+W8dxvI9gDkRgBXWpNsNrg
	 N8KpaM3w764/WiF3ay+l8MbMXik7+rorgMTY1KurzZo+owOkz93Q+LQTGXoeK/OYJT
	 Pmy7TWroPbCFPT4yJM1pc7HKKcCgim0Npl9Yy7nWYEST8CK0WIGIav7VCifR4FnEw1
	 CHf76JptW+Nh+96nftkOxDWAlRTv0urS78+wOPhSmsqWAyI7F99fL/HPB6FlF2kfUc
	 DylMnX8T4In/A==
Content-Type: multipart/mixed; boundary="===============2721682741473554854=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9598e12851c93f183b337cc01433927b2b012454eb275515857271a57d29202e@mail.kernel.org>
In-Reply-To: <20260814124843.22041-4-i.tellez@btesa.com>
References: <20260814124843.22041-4-i.tellez@btesa.com>
Subject: Re: [PATCH v2 bpf 3/4] bpf: Read producer_pos before overwrite_pos in ringbuf_avail_data_sz()
From: bot+bpf-ci@kernel.org
To: i.tellez@btesa.com,andrii.nakryiko@gmail.com,ast@kernel.org,daniel@iogearbox.net
Cc: andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,billy@starlabs.sg,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,i.tellez@btesa.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 13:30:57 +0000 (UTC)

--===============2721682741473554854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiBicGY6IFJlYWQgcHJvZHVjZXJfcG9zIGJlZm9yZSBvdmVyd3JpdGVfcG9zIGluIHJpbmdidWZf
YXZhaWxfZGF0YV9zeigpCj4KPiBUaGUgcHJvZHVjZXIgZG9jdW1lbnRzIHRoZSBvcmRlciB0aGUg
Y29uc3VtZXIgaGFzIHRvIHVzZSwgaW4KPiBfX2JwZl9yaW5nYnVmX3Jlc2VydmUoKToKPgo+ICAg
ICAgICAgICogc21wX3N0b3JlX3JlbGVhc2UoJnJiLT5wcm9kdWNlcl9wb3MsIG5ld19wcm9kX3Bv
cykgYXQKPiAgICAgICAgICAqIHRoZSBlbmQgb2YgdGhlIGZ1bmN0aW9uIGVuc3VyZXMgdGhhdCB3
aGVuIGNvbnN1bWVyIHNlZXMKPiAgICAgICAgICAqIHRoZSB1cGRhdGVkIHJiLT5wcm9kdWNlcl9w
b3MsIGl0IGFsd2F5cyBzZWVzIHRoZSB1cGRhdGVkCj4gICAgICAgICAgKiByYi0+b3ZlcndyaXRl
X3Bvcywgc28gd2hlbiBjb25zdW1lciByZWFkcyBvdmVyd3JpdGVfcG9zCj4gICAgICAgICAgKiBh
ZnRlciBzbXBfbG9hZF9hY3F1aXJlKHItPnByb2R1Y2VyX3BvcyksIHRoZSBvdmVyd3JpdGVfcG9z
Cj4gICAgICAgICAgKiB3aWxsIGFsd2F5cyBiZSB2YWxpZC4KPgo+IHJpbmdidWZfYXZhaWxfZGF0
YV9zeigpIHJlYWRzIHRoZW0gdGhlIG90aGVyIHdheSByb3VuZCwgc28gdGhlIGFjcXVpcmUKPiBs
b2FkIG9mIHByb2R1Y2VyX3BvcyBubyBsb25nZXIgb3JkZXJzIHRoZSBsb2FkIG9mIG92ZXJ3cml0
ZV9wb3MuIE5vdGhpbmcKPiB0aGVuIHByZXZlbnRzIHRoZSBwYWlyIGZyb20gYmVpbmcgb2JzZXJ2
ZWQgYXMgYSBzdGFsZSBvdmVyd3JpdGVfcG9zIG5leHQKPiB0byBhbiBhbHJlYWR5IGFkdmFuY2Vk
IHByb2R1Y2VyX3Bvcywgd2hpY2ggb3ZlcnN0YXRlcyB0aGUgYW1vdW50IG9mCj4gYXZhaWxhYmxl
IGRhdGEgYnkgaG93ZXZlciBmYXIgdGhlIHByb2R1Y2VyIG1vdmVkIGluIGJldHdlZW4uCj4KPiBT
d2FwIHRoZSB0d28gbG9hZHMgc28gdGhlIGRvY3VtZW50ZWQgY29udHJhY3QgaG9sZHMsIGFuZCBz
YXkgd2h5IGluIGEKPiBjb21tZW50Lgo+Cj4gU2lnbmVkLW9mZi1ieTogSXNyYWVsIFTDqWxsZXog
R2FyY8OtYSA8aS50ZWxsZXpAYnRlc2EuY29tPgoKVGhpcyBsb29rcyBsaWtlIGEgYnVnIGZpeCBm
b3IgYSBtZW1vcnkgb3JkZXJpbmcgaXNzdWUuIFNob3VsZCB0aGlzIGluY2x1ZGU6CgogIEZpeGVz
OiBiNzMyNDZmZjg3NWIgKCJhZGRpbmcgY2kgZmlsZXMiKQoKCi0tLQpBSSByZXZpZXdlZCB5b3Vy
IHBhdGNoLiBQbGVhc2UgZml4IHRoZSBidWcgb3IgZW1haWwgcmVwbHkgd2h5IGl0J3Mgbm90IGEg
YnVnLgpTZWU6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy92bXRlc3QvYmxvYi9t
YXN0ZXIvY2kvY2xhdWRlL1JFQURNRS5tZAoKQ0kgcnVuIHN1bW1hcnk6IGh0dHBzOi8vZ2l0aHVi
LmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9ucy9ydW5zLzMxODAyODM2OTY0

--===============2721682741473554854==--
