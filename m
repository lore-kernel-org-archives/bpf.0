Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AAC308F39;
	Wed, 20 May 2026 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259040; cv=none; b=MFdpBrJvZW9HONEnGQaxxfxAOTkvjBaXkxXOTGPpx+2I6mYOR+D3HNQYKeRod+2j9ZBDlavFUuglUkmou6W7h1XEKeSbNSyi2ZpoEIbz879LNUd7tHNYqJCHki9PZEROEZw/8Tt4Pz/FYB2PsaIUGXt4DCkJime2WxI+pR2EKP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259040; c=relaxed/simple;
	bh=Hc02KHIQwFQuLYM6vR51nlrq7VeOOmctYi/wzCzjdTo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YCf6phtqg5CAuy/yM1zyq8xjA+oizPXNpTlNPoSxMVk97Hx4DIVoT6CT12+TrhAmti3/EC5MyXrorWF3PUFJ+wieivm86GlyAAzKsXhKx9IaeSGQWuzGJMkGWwsm21ndMzn5Vbb3tGEkMJeK12CktrSYzlf1UKwDn9Hl0+CGq7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=r9Pnb7Ve; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T22VArq1; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="r9Pnb7Ve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T22VArq1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 09A0B1400098;
	Wed, 20 May 2026 02:37:13 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 20 May 2026 02:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779259033;
	 x=1779345433; bh=SFgVSM4D3f4MMNW5LhTDgu5hm2z6zSDZXZtPgltc+tU=; b=
	r9Pnb7Venwr8FBOBbX1k8PhD0uo+yTtb+/A0kOvdoiI96IsVJKBr/svQeeGRs0cv
	f4ImJIJntfwCw3/HeVNVKKT11+IJ0Ik/8CfWuBlVV9dw+y52QIRFE+P8+AH7Dxl4
	96n9F/qX7GS9kp4KCZ6eZwVaWvo9o5kqQeAInBuTducfZZTddG0PQxqhI9K+AiHT
	gU95ZIaWLd/y77bMvGWY7zbmVIpfhbybxPh5Jm9QYR8G0swUm7+LlUFEsip8XeIO
	KrpDDoY32Sa5w+wfT9vjI4YUlatFzGnnCFahGWb9qiu4s6r7HTrgov68hh9J/Wz2
	6Iqw2VDkXaJkjRK7H54OUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779259033; x=
	1779345433; bh=SFgVSM4D3f4MMNW5LhTDgu5hm2z6zSDZXZtPgltc+tU=; b=T
	22VArq1+tEYjR1fzPQVSGwcZbOHfT3Eyc/LH5BNuEKgmlzsajGP1DVakdN5oxOeo
	uYguMEf0n+h54p5ya5iqspZ9sFgGKKW+pSaaYPAW2YLdd66LnjjLJP/rAw6v33PC
	4l5oFGX8Dp0W51qHLgHLJu5M8cyAi+aWHOF5g7WP2CFEgUO8aXD8PuyxVuOMNKvK
	U1+ep51gFsj+DUckYzOzSAJ/7WeZVVQceiejwNDrfV15JFOvZ4xVffpiTPXfjDw+
	EPpdY40zEd9AWLNOluu4J5XvgWK2n5JJsXunZeAiobP0/2E4x5BDEHa2rh6N9LEQ
	8+/2iXvUXrP7XIig29nuA==
X-ME-Sender: <xms:mFYNatwMgZZ9iBE3HuB3QGLJJQ3py0o7POA6UV9EY-VEpcyecN7LUQ>
    <xme:mFYNaoH13oSh2ExPlOqFt32sEf1y4DJfVvgMfIbS4XTGlwxVoIn9M4ft5Hg63_QJo
    sMFJKM-7Z9TtLcXpzz_o_ecGOZbPZ3mXEgS_rVVDT8_MZCTu5dSjSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    gvmhigohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrnhhivghlsehiohhgvggr
    rhgsohigrdhnvghtpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhholhhsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhonhhg
    sehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mFYNarJRacokUrjQ4zRRu5x5KsrDYSGVHv2RWzPA5-Pvc3K9UzQHCw>
    <xmx:mFYNauvzcxgLvuZE2CMvAkSx_rRAJv7LvpT3FRzfX7LEJwPe1nIATw>
    <xmx:mFYNaoCQox8t4n-da14KZJXrHxFb-pYIyePzfWKO3X16cZkZLLeKEw>
    <xmx:mFYNam4GWOPPxbcAYWB5-DkdV_Md1K7-YOY7CSnD5w-6L00GQwIvYQ>
    <xmx:mVYNagDSg_MKnkcT2b1oDZwKxyA6uqSwfgh9FTrPd01eneImzMKs9WEY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A17FF182007A; Wed, 20 May 2026 02:37:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqrpfhGWoMQB
Date: Wed, 20 May 2026 08:36:51 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yonghong Song" <yonghong.song@linux.dev>,
 "Arnd Bergmann" <arnd@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Leon Hwang" <leon.hwang@linux.dev>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Jiri Olsa" <jolsa@kernel.org>, "KP Singh" <kpsingh@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <8e9cdb17-83c6-4287-91eb-dd6d3a457f28@app.fastmail.com>
In-Reply-To: <9eecfab7-afac-4144-b544-ac715b07980e@linux.dev>
References: <20260519203858.1342507-1-arnd@kernel.org>
 <9eecfab7-afac-4144-b544-ac715b07980e@linux.dev>
Subject: Re: [PATCH] bpf: avoid padding in struct bpf_common_attr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, May 20, 2026, at 00:17, Yonghong Song wrote:
> On 5/19/26 1:38 PM, Arnd Bergmann wrote:
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index cc4c0b62cdfa..0f0ec00cae4a 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1507,6 +1507,7 @@ struct bpf_common_attr {
>>   	__u32 log_size;
>>   	__u32 log_level;
>>   	__u32 log_true_size;
>> +	__u32 __pad;
>
> Let us make it as
> 	__u32 :32;
> ?
> This can avoid people to use the '__pad' name.

Sure. Do you want me to resend, are are you going to change
it yourself?

> IIUC, typically uapi struct won't have implicit padding.

Correct. I have a patch set that I'm testing to add the
Warning to the kernel build process to find these
automatically, but I first need to take care of all the
existing instances and only report newly added ones at
the moment.

FWIW, see below for what I currently have in my private
tree for linux/bpf.h. Most of these ones are architecture
independent, so I just do the same '__u32 :32' that you
suggested above. For bpf_cgroup_storage_key and
bpf_attr::link_create::{tracing,tcx,expected_revision,cgroup}
there is an additional problem sinc ethe 64-bit fields
use __u64 instead of __aligned_u64.

This makes the structure layout incompatible between
i386 and x86_64. In the version below I use a
__uapi_arch_pad32 macro to have architecture specific
padding that keeps the existing behavior, but this
technically also requires adding a compat syscall
on x86 (but no other compat architectures) to convert
between the two layouts.
Using __aligned_u64 consistently here would have avoided
this problem, but changing it later is not an ABI
change that would affect every architecture with
unaligned __u64 (arc, csky, m68k, microblaze, nios2,
openrisc, sh and i386).

      Arnd


diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index aec171ccb6ef..0f0ec00cae4a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -111,7 +111,8 @@ struct bpf_lpm_trie_key_u8 {
 struct bpf_cgroup_storage_key {
 	__u64	cgroup_inode_id;	/* cgroup inode id */
 	__u32	attach_type;		/* program attach type (enum bpf_attach_type) */
-};
+	__uapi_arch_pad32;
+} __uapi_arch_align;
 
 enum bpf_cgroup_iter_order {
 	BPF_CGROUP_ITER_ORDER_UNSPEC = 0,
@@ -1562,10 +1564,12 @@ union bpf_attr {
 		__aligned_u64 excl_prog_hash;
 		/* Size of the passed excl_prog_hash. */
 		__u32 excl_prog_hash_size;
+		__u32		:32;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_FREEZE commands */
 		__u32		map_fd;
+		__u32		:32;
 		__aligned_u64	key;
 		union {
 			__aligned_u64 value;
@@ -1668,6 +1672,7 @@ union bpf_attr {
 		 * if BPF_F_PATH_FD flag is not set, AT_FDCWD is assumed.
 		 */
 		__s32		path_fd;
+		__u32		:32;
 	};
 
 	struct { /* anonymous struct used by BPF_PROG_ATTACH/DETACH commands */
@@ -1708,6 +1713,7 @@ union bpf_attr {
 		__u32		flags;
 		__u32		cpu;
 		__u32		batch_size;
+		__u32		:32;
 	} test;
 
 	struct { /* anonymous struct used by BPF_*_GET_*_ID */
@@ -1809,6 +1815,7 @@ union bpf_attr {
 			struct {
 				__aligned_u64	iter_info;	/* extra bpf_iter_link_info */
 				__u32		iter_info_len;	/* iter_info length */
+				__u32		:32;
 			};
 			struct {
 				/* black box user-provided value passed through
@@ -1827,12 +1834,13 @@ union bpf_attr {
 			struct {
 				/* this is overlaid with the target_btf_id above. */
 				__u32		target_btf_id;
+				__uapi_arch_pad32;
 				/* black box user-provided value passed through
 				 * to BPF program at the execution time and
 				 * accessible through bpf_get_attach_cookie() BPF helper
 				 */
 				__u64		cookie;
-			} tracing;
+			} __uapi_arch_align tracing;
 			struct {
 				__u32		pf;
 				__u32		hooknum;
@@ -1844,8 +1852,9 @@ union bpf_attr {
 					__u32	relative_fd;
 					__u32	relative_id;
 				};
+				__uapi_arch_pad32;
 				__u64		expected_revision;
-			} tcx;
+			} __uapi_arch_align tcx;
 			struct {
 				__aligned_u64	path;
 				__aligned_u64	offsets;
@@ -1854,12 +1863,14 @@ union bpf_attr {
 				__u32		cnt;
 				__u32		flags;
 				__u32		pid;
+				__u32		:32;
 			} uprobe_multi;
 			struct {
 				union {
 					__u32	relative_fd;
 					__u32	relative_id;
 				};
+				__uapi_arch_pad32;
 				__u64		expected_revision;
 			} netkit;
 			struct {
@@ -1867,6 +1878,7 @@ union bpf_attr {
 					__u32	relative_fd;
 					__u32	relative_id;
 				};
+				__uapi_arch_pad32;
 				__u64		expected_revision;
 			} cgroup;
 		};
@@ -1922,6 +1934,7 @@ union bpf_attr {
 		__u32		stream_buf_len;
 		__u32		stream_id;
 		__u32		prog_fd;
+		__u32		:32;
 	} prog_stream_read;
 
 	struct {
@@ -6648,6 +6661,7 @@ struct sk_reuseport_md {
 	__u32 ip_protocol;	/* IP protocol. e.g. IPPROTO_TCP, IPPROTO_UDP */
 	__u32 bind_inany;	/* Is sock bound to an INANY address? */
 	__u32 hash;		/* A hash of the packet 4 tuples */
+	__u32 :32;
 	/* When reuse->migrating_sk is NULL, it is selecting a sk for the
 	 * new incoming connection request (e.g. selecting a listen sk for
 	 * the received SYN in the TCP case).  reuse->sk is one of the sk
@@ -6706,6 +6720,7 @@ struct bpf_prog_info {
 	__u32 verified_insns;
 	__u32 attach_btf_obj_id;
 	__u32 attach_btf_id;
+	__u32 :32; /* alignment pad */
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
@@ -6727,6 +6742,7 @@ struct bpf_map_info {
 	__u64 map_extra;
 	__aligned_u64 hash;
 	__u32 hash_size;
+	__u32 :32; /* alignment pad */
 } __attribute__((aligned(8)));
 
 struct bpf_btf_info {
@@ -6742,6 +6758,7 @@ struct bpf_link_info {
 	__u32 type;
 	__u32 id;
 	__u32 prog_id;
+	__u32 :32; /* pad to alignof(__aligned_u64) */
 	union {
 		struct {
 			__aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
@@ -6759,6 +6776,7 @@ struct bpf_link_info {
 		struct {
 			__u64 cgroup_id;
 			__u32 attach_type;
+			__uapi_arch_pad32;
 		} cgroup;
 		struct {
 			__aligned_u64 target_name; /* in/out: target_name buffer ptr */
@@ -6777,11 +6795,16 @@ struct bpf_link_info {
 				struct {
 					__u64 cgroup_id;
 					__u32 order;
+					__uapi_arch_pad32;
 				} cgroup;
 				struct {
 					__u32 tid;
 					__u32 pid;
 				} task;
+				struct {
+					__u64 :64;
+					__u64 :64;
+				};
 			};
 		} iter;
 		struct  {
@@ -6896,6 +6919,7 @@ struct bpf_sock_addr {
 	__u32 msg_src_ip6[4];	/* Allows 1,2,4,8-byte read and 4,8-byte write.
 				 * Stored in network byte order.
 				 */
+	__u32 :32;		/* pad to alignof(u64) */
 	__bpf_md_ptr(struct bpf_sock *, sk);
 };
 
@@ -7555,6 +7579,7 @@ struct bpf_sk_lookup {
 	__u32 local_ip6[4];	/* Network byte order */
 	__u32 local_port;	/* Host byte order */
 	__u32 ingress_ifindex;		/* The arriving interface. Determined by inet_iif. */
+	__u32 :32;
 };
 
 /*
