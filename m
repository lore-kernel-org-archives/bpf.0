Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F353E023B
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295924; cv=none; b=aLse2+vm6tP/E1ghRQur/wGnnwsCgFIMkUqbKdbbaasZ8J+R5qratbPXVanEHaK/JlD4uhwlpM7173SAvEh8qnFplNpZpY1+XXVCDa4J5yHiGR/DN5QrjMHMg7PguX3IcS3E6XmDRLA1+gKCntsDHWKGtwrDk3g5SHAvy8goQj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295924; c=relaxed/simple;
	bh=rFwavVi+8NywFOavv+CTnqRbAs/RfxCJiCb22GYzD4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3D3vzyZwws+lNvangYQa9PyBVf6/N/Gd5bVS5avnwU8sMvOS4PD6+rTxNt6Ds2lrGoeFo3Nh//8wJ/IryXBNSZ5vrq9o5KFqYH6NYW1Hd2hDJjmtZ5mkvRpVxhcBl7We6ZLfl6l/f9O8lYJqcIqmTdjQ/w0WcjzaU3pSNiWXgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MlX3ojn6; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MlX3ojn6"
Message-ID: <b040711c-0fd1-475f-b807-e4e0b4324f6e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774295918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rn73FXH3fs3jvnnP3trpMCtHc3fOPcpCNW4XYaXzEdM=;
	b=MlX3ojn6IBGxEE68qm40rXLRyCOzI/MaYB02KvED/lHmq+TliOfwrxwOKbC6yhYOp1gkHw
	f7LfnIq8fz7jRkSyEImf8TGP9Z4PIaH9adDsRBnKaK3hbLK+r6bd9bAWAxeI+VKccSvbKl
	0D9CaaASwFJMTK0d9wLxZBzkJVzrIyc=
Date: Mon, 23 Mar 2026 12:58:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <CAADnVQ+iXJK46cFcGN-Ta8KGxe7Y+m_DxgWNS=QC-gOWT=WxCw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQ+iXJK46cFcGN-Ta8KGxe7Y+m_DxgWNS=QC-gOWT=WxCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/21/26 1:27 PM, Alexei Starovoitov wrote:
> On Wed, Mar 18, 2026 at 4:42 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>>                                         const struct btf *btf,
>> @@ -12594,6 +12620,14 @@ enum special_kfunc_type {
>>         KF_bpf_session_is_return,
>>         KF_bpf_stream_vprintk,
>>         KF_bpf_stream_print_stack,
>> +       KF_bpf_obj_new,
>> +       KF_bpf_percpu_obj_new,
>> +       KF_bpf_obj_drop,
>> +       KF_bpf_percpu_obj_drop,
>> +       KF_bpf_refcount_acquire,
>> +       KF_bpf_list_push_front,
>> +       KF_bpf_list_push_back,
>> +       KF_bpf_rbtree_add,
>>  };
> 
> it's not an uapi. no need to add them to the end.
> Pls add them next to _impl flavors.
> 
> The whole thing needs a full refactor in a long term.
> special_kfunc* thingy got out of hand.

I thought about this a little and tried a couple of ideas.  Here is
one that looks a bit better to me than KF_* enum: BTF_ID_LIST_NAMED()
and BTF_ID_NAMED().

I vibe-coded a PoC [1]. Essentially, we add a set of macros to
generate source-level stable symbol for each BTF_ID_LIST entry. Then
it is possible to refer to the associated value directly by name.

It looks like this:

+#define BTF_ID_LIST_NAMED(name)                                \
+       __BTF_ID_LIST(name, local)                      \
+       extern u32 name[];
+
+#define BTF_ID_NAMED(list, prefix, name)               \
+       __BTF_ID(__BTF_ID__##prefix##__##name##__##list, "") \
+       extern u32 __btf_id_##list##__##prefix##__##name \
+               asm("__BTF_ID__" #prefix "__" #name "__" #list);
+
+#define btf_id_named(list, prefix, name) \
+       (__btf_id_##list##__##prefix##__##name)
+

And then:

+BTF_ID_LIST_NAMED(special_kfunc_list)
+BTF_ID_NAMED(special_kfunc_list, func, bpf_obj_new_impl)
+BTF_ID_NAMED(special_kfunc_list, func, bpf_obj_drop_impl)

  [...]

+#define special_kfunc_id(name) btf_id_named(special_kfunc_list, func, name)

  [...]

 static bool is_bpf_obj_new_kfunc(u32 func_id)
 {
-       return func_id == special_kfunc_list[KF_bpf_obj_new] ||
-              func_id == special_kfunc_list[KF_bpf_obj_new_impl];
+       return func_id == special_kfunc_id(bpf_obj_new) ||
+              func_id == special_kfunc_id(bpf_obj_new_impl);
 }


The benefit of this is that we can delete enum special_kfunc_type, and
there is only one list where a special kfunc has to be defined (and this
may work for other similar use cases).

The downside is additional BTF_ID macrology, and potentially changes
in resolve_btfids.

What do people think, is this worth pursuing?

[1] https://github.com/theihor/bpf/commit/be38dde0a027d7ab84d8d20ac266251fb938ceb6

> 
> pw-bot: cr

