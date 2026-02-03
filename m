Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2A3176F8;
	Tue,  3 Feb 2026 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160899; cv=none; b=IKOWeMm8+3smVPd04hT/DTLBUz59bvIGV+qnp7ybOseieg5G7Js4ltXWprTGHA45ywYOzbbbdLyq/T6yk43SoP+Li9EDx6aQXGBCW01GJzBMQc/cT6dHkKuRG6c/zGol569dz+BQbgY7NwfnjNyHI6AIZdgGSXqD8zHyX8RljPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160899; c=relaxed/simple;
	bh=y8xI2SLsEcaVa2PibKlLesLqqgz2+RlkrPaT0/f/p0U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=U/3HNOW8186Hv6kAz6WhAEHzpNX63ZxoarTLPtCN/rbTREBy1GT63Bh9770M8kQFQ4eroEFfFZkASURSRoOnn/3RGvFEVxbXIMrnf9XuvxjUape/OvDCvz5Tch6EjwSauOqzKB22W7ci8XW8skKTmRcljbr4EHHEDdO7uA6vQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pcgDSuX9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AG8hgGwC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pcgDSuX9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AG8hgGwC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 93FA27A01C7;
	Tue,  3 Feb 2026 18:21:36 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 03 Feb 2026 18:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770160896;
	 x=1770247296; bh=qY8ad4qOixeNlq/iFIcOB3UybfN7ZR7JcVlQcM6B+vc=; b=
	pcgDSuX9MTGLBJhabT1/yBhH9UNebMXhoEtnRjCMcJSZWtwbKiBKUD5VCGfq1tx3
	YyD4cnzA0I2qPkufzqmHHO9gTMpZ9IZImLmP4MJ43Cl+MItEsDaYqqKdbtn4lk5y
	nRQymB5Abrt9mmi8gVgfCStkta3rg3M0EVdqP2WxfG461ZGEuhojY8RVYuQU0lTd
	tFVe661ypO8Ytkqhs6tB+KsVgC9fgt9g6lt3l9XVwHtDJZLgdvIZ3jENz5Dx75hu
	Cbkti+3whzcT7RIyoZ1R8y5q6BNWwgoKAhQ5Xezf4oR3CYgfzGeMGJNXwh8eCZJ+
	BEwfG/aQ5ol1yzLzNMUa8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770160896; x=
	1770247296; bh=qY8ad4qOixeNlq/iFIcOB3UybfN7ZR7JcVlQcM6B+vc=; b=A
	G8hgGwCx5I66rBBPhdHJA7VUhFU8CekAI1g5ZaTEYBvmgqRxVIlipINvAcIbz6Nq
	sXOejByBbTrGsR4EhIJkBNJ3Mbbo2DXd7Qzhv2iAwSN2FTUB7mJblUop3CtXOpIi
	83xh5xC643n7b4hcgjErV0U8kuVo2NrzuUk1Yg0LKbyo70gvaN2J1xHenOZwvcz+
	y6uM1h2ZlUy5X2JArTWXPM4dy0ptL13ypzDjiFn78MzwMJ6Px5W1hdOMMuFYXiW/
	hHYK4e6PuXpvcl8nfO46VHlJzGOW5la1Nir4kCzo6PJ4n/rg9yHmk1R4TDWmCfLe
	6BRcGlAhqbbmlVOy7VcrA==
X-ME-Sender: <xms:_4KCaQlTedOqZPsp5NGQ3AKQJKjU1Lom_1e62cL8Mbe9irVTG9_NIg>
    <xme:_4KCaapEHUGBsH-JRm3HvxL2aTiOWKS9JJsuEnyVvyce7Yt4SY6I-xTkyVcxghUg5
    LN5iSD01Z5KRlCl3Hxw6HJGroJvgnjs69utQeDnfH-zFjj9N_ZDjLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedufeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhosh
    drtghomhdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohep
    rghlvgigvghirdhsthgrrhhovhhoihhtohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhdrfhgrshht
    rggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehmvghmgihorhesghhmrghilh
    drtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghp
    thhtohephhgrohhluhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehmrghtthgsoh
    gsrhhofihskhhisehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:_4KCaYDCEoxJRsILa9q65M4GluwwOO0QfLMIe27Wd3gOM0GW_K8aGQ>
    <xmx:_4KCaWF3zZLy5sDBOUDvo1ubj7vcCLTAc5HdOL22Hd63cG0_w5vd2w>
    <xmx:_4KCabmWIxTNJtAoEK1yWlvMVZiTiQWafVOFkzj5ScvZtL3NsuhB6g>
    <xmx:_4KCaTtWbu8tm1XdrjxH3r_JpyvCkadyJZHQl8mTxRLjNkunZ1SWzQ>
    <xmx:AIOCaZoUB1CVdbuE7VC_c9rNYGMB9MZ6AR-4Ur8CmPPGVX4jgzyKkwi5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6073A700065; Tue,  3 Feb 2026 18:21:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATnu9ZDQUFrg
Date: Wed, 04 Feb 2026 00:21:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Song Liu" <song@kernel.org>,
 "KP Singh" <kpsingh@kernel.org>, "Matt Bobrowski" <mattbobrowski@google.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Mykyta Yatsenko" <yatsenko@meta.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Message-Id: <0d5b64a5-8cf9-45c7-8848-ac62d3fdca44@app.fastmail.com>
In-Reply-To: 
 <CAADnVQK3eZp3yp35OUx8j1UBsQFhgsn5-4VReqAJ=68PaaKYmg@mail.gmail.com>
References: <20260203162746.2337002-1-arnd@kernel.org>
 <CAADnVQ+14yum8okMmjuqF5m5DafWo1fY1EuPj-QU_ykYbQ01uw@mail.gmail.com>
 <5f9c89fe-df1d-4eb4-b724-08f8d90fcc59@app.fastmail.com>
 <CAADnVQKn4xP9s_koBuP7D_eqUX0dSPwUr-dOj3mTZNTh_VxqKQ@mail.gmail.com>
 <ab709a00-3a7f-423f-9d8b-b2cd17fef76f@app.fastmail.com>
 <CAADnVQK3eZp3yp35OUx8j1UBsQFhgsn5-4VReqAJ=68PaaKYmg@mail.gmail.com>
Subject: Re: [PATCH] bpf: add missing __printf attributes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026, at 19:11, Alexei Starovoitov wrote:
> On Tue, Feb 3, 2026 at 9:44=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:
>> On Tue, Feb 3, 2026, at 18:24, Alexei Starovoitov wrote:
>> I also see the comment about bstr_printf() mention that it
>> uses a vsnprintf() compatible format, which would indicate that
>> marking the format argument isn't wrong, though I agree it is
>> not actually useful if there are no callers that pass a string
>> literal.
>
> In general I don't think it's a good idea to add nop annotations
> just to shut up over eager compiler warning.

I've tried removing these three below, which now gives me
a clean build with -Wsuggest-attribute=3Dformat, after the
other three patches I posted for unrelated code.

     Arnd

diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index d6ebf0596510..2fb266ea69fa 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -181,7 +181,6 @@ int seq_open_private(struct file *, const struct seq=
_operations *, int);
 int seq_release_private(struct inode *, struct file *);
=20
 #ifdef CONFIG_BINARY_PRINTF
-__printf(2, 0)
 void seq_bprintf(struct seq_file *m, const char *f, const u32 *binary);
 #endif
=20
diff --git a/include/linux/string.h b/include/linux/string.h
index 1b564c36d721..b850bd91b3d8 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -336,8 +336,8 @@ int __sysfs_match_string(const char * const *array, =
size_t n, const char *s);
 #define sysfs_match_string(_a, _s) __sysfs_match_string(_a, ARRAY_SIZE(=
_a), _s)
=20
 #ifdef CONFIG_BINARY_PRINTF
-__printf(3, 0) int vbin_printf(u32 *bin_buf, size_t size, const char *f=
mt, va_list args);
-__printf(3, 0) int bstr_printf(char *buf, size_t size, const char *fmt,=
 const u32 *bin_buf);
+int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list arg=
s);
+int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin=
_buf);
 #endif
=20
 extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *=
ppos,
