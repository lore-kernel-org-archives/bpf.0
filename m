Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED75383338
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711711; cv=none; b=aogvweZHv7/FaJzmyazW5k7LyIsrf6mzkApcp1uzvkkbSoKILIxSbeEsgdMnekxwhPgnLqdw0rkwbLjepN/Tq9ZX68SNOGjld0yk02VdT2w+/TkOzMnuqJ9QzL5wPUQN+9az46R5S3V2a3/hwtaIVcC8eVorwSfzLZSrlI+BkZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711711; c=relaxed/simple;
	bh=c6hY0TLeDSV5AMDSqRm8hCkvr7s1rq6x1vYyUALqD6Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GFeJGl1UUwfgTihBPmh9MZpaEbOcPkEM2iSsE1ao9k/vlewVvkwBjjYOmYXzzn6ygTukdmFS4pEXR/5tZa/ngaTmjrF7ApzrTFI0bQLNp98CdO8lWYRteJyDld0l2UWMZ57Xra1u4UQ2AOqTWYq0Zozfxs5YIkugheXjgKVAKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFRRrTIY; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFRRrTIY"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-133466cf955so1117914c88.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711709; x=1779316509; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SXNCqoVNxl+yA9TLHYQ9aS809nax/c51C0zyfUUYCFA=;
        b=CFRRrTIYd/wxZyFo3cxCmBgcTByKJb95583nIJXn28UWPRqG2woSo/oZmKZ2ubenZP
         Xidv4EW3ENNnesRSJz8CoNOUkMaO7vMM/GvbGiSqhtRo0zNVRKVlSGBPWgQQS+s/4XfV
         n9Xnir72wEAV2rcVvF5XBQ5j0eWZKdpO6lQ9pVtyf74iz2ZAmlZH30wUf3uvBZcCX2og
         Cj+bBoJS9vSeVaSqXWO8I2g9KaDAy4Q6Sr7zcO7Hqau0r+JUyXJCcOtPlrNEitZlLEAk
         khEWmN3Axu0GXTDoY6AY3/mdyLww10xiGWBIyVj6cMDM7Fc5jUZxHjdDmHi1T7jqblbl
         VUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711709; x=1779316509;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXNCqoVNxl+yA9TLHYQ9aS809nax/c51C0zyfUUYCFA=;
        b=oeKMEU5Dr9NcWHj5zh5k+wShAhZ56GIdJSxIcWBlHDAk2hQtfv0ftx5PiP/DfcG50c
         Ut1eh4Vf966dqQnzlpon52rPoamQBaHY9sLYRSW/Q5y0tt1KG6+RyL3d/w3RuIyHm61p
         ep4KvVPxukHcE9hPmgcnhxQ8E5QiRob77na9r/NpHtIGju0cYzvjUNFQ2w+ObrzE4GGg
         38U8c3eAiHrP+utK55Aw01om3dskejljkVkYG/6C0ykJ3OTX2r6f91lAGTXvxls1cToV
         7P+XWKAMjy5CwuFzaOvxpq2neB4WCeHpGUPgJWComxuaB93Q69jZ2XUCBAODOqUAQh1n
         4hcA==
X-Gm-Message-State: AOJu0Yz44flZt4p4Vqmi6ZXowdO0FNT4NPZHsMJg167BVsMLswyYlain
	k4CQ7C3vjZwHunfB7rLUkKbSYdBh7bByDFlDHkC4VAd1Lb6fMu/gtmec
X-Gm-Gg: Acq92OEHSk0NURDeud/xNdkdAebz+GFVLl21v2TkxBob83mfqWJA6zdv+WLGQxVn5o6
	WfP+zgpoZiKOV6+hNVugme3DZyv/mkpkB0VD1o4SPvYAwz1KWLItfn3zL3JNy/GpagMFLc7yVFa
	QHwECms+T/kFxeXixViCHwpOghOb3OL6h4zaeeHoTw8s6T5FKLZOs+n9y9xc4Cs2vXbt0QjaGr6
	D0cQv5NdmUXMh3I03aJgPAns+fBgrCBQbX4Bn/rv4sfzAaEprGEOHPPF/+t6y1wwcxD+3JOQqWj
	/B3d9VjkBRKVqSgIeHCARiLscrnk4wyCv5+zAqzw7+/Adf/oA+fXHbo2wWBcmjlEFdtOpCP1Sk6
	aBfII2F2+Hep6cqyJR8vn2Ayz+yMNkB/IJ6oOrlYM8KuRFjTN6+Lhn1+YyHgOaOM6/NFze0lsFe
	oJNNGa3CZ56su8N/ojLZl0gZZuVzG/LmBPPLr4MzD4kLEEB9bh5tHfoZ2k9TNSQ5h9zIqXyTUIT
	r5JHbo=
X-Received: by 2002:a05:7022:f8d:b0:128:bae0:e03c with SMTP id a92af1059eb24-13436a9e59bmr3032396c88.30.1778711709309;
        Wed, 13 May 2026 15:35:09 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5152:641f:f5ef:6c7b? ([2620:10d:c090:500::2:8a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294adddaasm768297eec.13.2026.05.13.15.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:35:08 -0700 (PDT)
Message-ID: <237f26933259d2a9114b4abd9cd7773b788c2038.camel@gmail.com>
Subject: Re: [PATCH RESEND bpf-next v10 5/8] bpf: Add bpf_list_add to insert
 node after a given list node
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kaitao cheng <kaitao.cheng@linux.dev>, ast@kernel.org, corbet@lwn.net, 
	martin.lau@linux.dev, daniel@iogearbox.net, andrii@kernel.org,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, 	chengkaitao@kylinos.cn, skhan@linuxfoundation.org,
 memxor@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, vmalik@redhat.com,
 linux-kselftest@vger.kernel.org
Date: Wed, 13 May 2026 15:35:06 -0700
In-Reply-To: <20260512055919.95716-6-kaitao.cheng@linux.dev>
References: <20260512055919.95716-1-kaitao.cheng@linux.dev>
	 <20260512055919.95716-6-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-12 at 13:59 +0800, Kaitao cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>=20
> Add a new kfunc bpf_list_add(head, new, prev, meta, off) that
> inserts 'new' after 'prev' in the BPF linked list. Both must be in
> the same list; 'prev' must already be in the list. The new node must
> be an owning reference (e.g. from bpf_obj_new); the kfunc consumes
> that reference and the node becomes non-owning once inserted.
>=20
> We have added an additional parameter bpf_list_head *head to
> bpf_list_add, as the verifier requires the head parameter to
> check whether the lock is being held.
>=20
> Returns 0 on success, -EINVAL if 'prev' is not in a list or 'new'
> is already in a list (or duplicate insertion). On failure, the
> kernel drops the passed-in node.
>=20
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -19228,8 +19231,11 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
>  		int struct_meta_reg =3D BPF_REG_3;
>  		int node_offset_reg =3D BPF_REG_4;
> =20
> -		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs =
*/
> -		if (is_bpf_rbtree_add_kfunc(desc->func_id)) {
> +		/* list_add/rbtree_add have an extra arg (prev/less),
> +		 * so args-to-fixup are in diff regs.
> +		 */
> +		if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_list_add] ||

Nit: same nit here, maybe add is_bpf_list_add_kfunc().

> +		    is_bpf_rbtree_add_kfunc(desc->func_id)) {
>  			struct_meta_reg =3D BPF_REG_4;
>  			node_offset_reg =3D BPF_REG_5;
>  		}
