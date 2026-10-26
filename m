Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793054554;
	b=fLvMioxgWRubxRlRcZWZ0xrVDdjV7yqcmTrfFO4/C54u4z3YFL33kRWsr0v5GkgTUnVK
	 JnNERkIDUAlYsJkdiHOpA7esqSQcA0wth71sndT+ZdJ66EyZxuj2Q0Vu7Y1AUFz3/FQyl
	 NIJ7/Wiq7zbdanV/k81uRkXYkWz+DeYZdNIe/cn6BxsBJVybn//QCuF6B3qyt38nV8mDB
	 Ht19G63sHs1Ne5J7pqHuXiQKPi+4L0YicznDd5jh5/snfBIu3KSh3HC42uvMtIPpsEl3+
	 nYa4x2OakCJyBUj1viUuID+h/N5IMRGy18NZV1O6sIdTNtiemw08QzeJi9FtCFlNlmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
	b=FLTw1qseUylPzGu7urd/XpAqyg5l6pOW+4Hrm7NSQFf13Oz4rEtlYNAJs2P8g5K5X6LR
	 jhsYdI6PqW1WYm/gilpEarmW9ejzdN//Vpxuh7xKfjnVKTpWUsEv7FAUyiOjmVXnO36FB
	 KX1a34S7pTCUJ8JKTD6LXP5eYMymsTSdhBGlC9XkmLS2R2H9ZkCy5Go+ksGzKQ7FQVz9n
	 5/zZ1VSJwVmZ/5MoXjRkOv0msJxhieE/JmFRtrxbaju0FYZpDN4pwv2jSILQpg8YrGuRZ
	 sMGTOEU6Kx4wJu7yF/Ly3GDV48WjqWgYYHyMf46RDuKRuPnbDJApcef6/NBrvQfoKTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ho8+h6Mf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC49606A327
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 22:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC49606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ho8+h6Mf
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so490746966b.3
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 15:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793054552; cv=none;
        d=google.com; s=arc-20260327;
        b=EYFkEJAT123SR+fzarm4TEpavsWRrP0FhJsdjBaGRbAHBqe7zOEwEZTBL2/zhcz80A
         7jEPPGfPlYBp6EigNR7dxa9FWbvZYTACgmZXLilEgziZwYGSKMV78JbAoSlaRT1ESb3E
         x+lXfZh2v5j6JQFDoF3pCbb8s46IJ09W3fiCXaacMHDimn8qAp4GID4+k4bk5nDiaAwA
         EEk/xT+g5y3uT+Xv1TJs+8FiQVNWX321EEMLwaFb35++bsvujVAhVS7P+3uULnrBxni6
         EMATBZW6DiCYPY5mhRtmu0PR/ixXKC4zaHwWAlBnGDqk73L6yrsAahlAOhCRx5jqiCAL
         yyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
        fh=e61SfStlx9McKKEm72TpwMDuR+v4W+CyeQKYIntiOwQ=;
        b=SkCF6bytAhK8V6fwN6nnS5xEg1RPuo70f4ghsh/4b/Z4DS2GeEiwI45YTAU/CMeeHN
         k4TQejaDrYrAoER/8A0+2sMGkm1H3EyY+swLvWH529Erek2UtpSAZ9DjOYy0LV5SibZ3
         l7bbsl3GmAUYXuKfh0joUD3umHOLEBzp2ozO53aWxV6yIxmUVyt9SBbe1w4e1zrBbGYm
         uxfhGD1AQUQhQETt0v86O9UVKzDh76ErOluksmgKyFU8j/VUKbqrOJCqmOoTuh7aUOAa
         +KE6cj2clJEDDi2mrfVQZ4j3yVhlewbTJQ3Tf6Mi9mGgTMEENyErPS815cTBcg4A0TZO
         PUqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793054552; x=1793659352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
        b=Ho8+h6MfzfNYBnYXWcB1Csn7RkH5FDAzc185C3faxOFFVI5Ip8rPZvUVVS9a7mPz36
         24gi8R8N3yA+KvfwmaRReqCQoQsNezGiPP1Bp7GiihlQBrxNS9eCbaY93g0l7+W+vIC0
         voQ2Heu+uMnZMYR6TuMnUotBhMhKn8fZO7YhZJ/VGMtSyWbiopW5EZJQ5vT2/6dOt2QP
         h6y7P/JEcSU5qhjYmxEPNqjJ3oooD2zuidI/sWorRbLSpg0w4GfbG7VlXLnZBZNxscre
         60kjozBonZXdnmTiD0g6qsMUd7kqNlcLdjiG7bhzjYU1/2dfEHHIUzSVvBAgpzwQCCET
         IiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793054552; x=1793659352;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
        b=cMyf7aE/5eUKYHs9Q95zHOmqpXMidnFBsWjxpwcDSsGw0PlWmKsBdfozhIi8QzaqhW
         oFKppx6ZpETfH8o1UiuTWi6sewgwRVezCaef8J9ibe6W3p+ucHJ4xVUpHm+l+vwACsSF
         ToRh+d0nCiv0iTYKUDdfAPkliMlfl0rupCoNspfOhu+iHbXazZX0kqhxLVwsJty1UofR
         GRLHov/VZtr/qMLRhxKBOBZWEW5W1VPwS57QdoFpN7HfQNuB4RvoUtCplRGnXVXu823/
         HZoBM6gQ9E6QGU/v/BDeT7E6FZgrRFwmD995od8+bnYd+nLVfF8iIxnZeBs3OUyA3pjo
         QVhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHfCogbE9Kn3kcN6W7gBxw5OFdkgAxa9zFtx0yATQ98Tg0HHF+Ic+vtW0bvewQNRvQh5A=@vger.kernel.org
X-Gm-Message-State: AFq9FYL90zFaw82WOXwBlZeq2uuvsaPqB3MTXES4O6GuOGXaZF2DXnT2
	9ngmVtbKuGWbswgjQRozqcUfMt56OR+rZ5fBXeySjxf4j8Cv3GS8qTTQl+WGLvcLId4PcbL2F/X
	D8Oas/ujLJ62G5czLT2oMAvyb/LzCN8pjw1IOmJwO
X-Gm-Gg: AYBFou2+Fm25XNQIGMTcmgL8EkvwEIl7Q/3l3pu4keGREJQ4azYhBrY+gJ23QI9Gen+
	kgmJgfNiCD+eFSuBbfqBLRCHsURI174I2kTNmo0tGy4cHUWSUFZWsXsykjjgb6F+Mt7j/M8coax
	FLLO0WfZTsxThLqkOGRmqTDcnlsBy3diQWeQSjelgkpoY61OXpRDKEVoPILmJLf7308guGvwy3k
	v3LEojraQHe0lUSOLEr/XyBI0XfCfRLuYkcpzH8vgc0QQN4IAu7Udsv6PEE8lypXR0oNzIr60cW
	Qvl2eye7HUmCdyYK2IkA8FjK7nRSmaTBNiJP1TS/UFNprjMenVwmJKjimvVqLPJPeujDjDt7DqS
	0TCkp27oe0XMbyFlnDHUTS82ZDTqQHIT6HQxwQDqd88Py2iBHit45sE75j+xiu52zDYx0S4tyNB
	NP8MT7jybCcBX18Flk6Fy9uGQMfKvyEF88PVTUAoPyDi7k3cjwEqapX4CbqCdJZvsJbmxSU1RYU
	1+fG/JG
X-Received: by 2002:a17:906:4fcb:b0:c46:8733:642b with SMTP id
 a640c23a62f3a-c46bdeba20dmr991156866b.43.1793054551213; Mon, 26 Oct 2026
 15:42:31 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-9-jthoughton@google.com> <da7bb91d95914febc9b2b981c0b8292022d6f6437ecb68ed2b717f0f4a3a04c2@mail.kernel.org>
In-Reply-To: <da7bb91d95914febc9b2b981c0b8292022d6f6437ecb68ed2b717f0f4a3a04c2@mail.kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Mon, 26 Oct 2026 15:41:52 -0700
X-Gm-Features: AclHuK9NQf_DmtP280VFWB18VLK39ZMzdxZm9Qsh_-4Snm7U1eOCkiznChHcSHY
Message-ID: <CADrL8HXA3KVX9agtcExpPuaBLC-zAEWx6QgsRnQ6+cb4AZZrFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] uaccess: Refuse and warn on __copy_from_user_inatomic()
 without an mm
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, tglx@kernel.org, 
	peterz@infradead.org, kees@kernel.org, arnd@arndb.de, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	jmattson@google.com, axboe@kernel.dk, asml.silence@gmail.com, 
	James.Bottomley@hansenpartnership.com, mkp@kernel.org, dsterba@suse.com, 
	mason@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, jpoimboe@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:30=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > uaccess: Refuse and warn on __copy_from_user_inatomic() without an mm
>
> TL;DR: Commit message only: it names kvm_read_guest_atomic(), which no lo=
nger
> exists in this tree; the review suggests kvm_vcpu_read_guest_atomic() ins=
tead.
>
> >     uaccess: Refuse and warn on __copy_from_user_inatomic() without an =
mm
> >
> >     __copy_from_user_inatomic() never called should_fail_usercopy(), so=
 the
> >     NULL current->mm check added to uaccess_should_fail() does not cove=
r it.
> >     It is used e.g. by KVM's kvm_read_guest_atomic(), by several
> >     architectures' perf callchain and stack trace code, and by the gene=
ric
> >     copy_from_user_inatomic_nontemporal().
> >
> >     Split the NULL mm check out of uaccess_should_fail() into
> >     uaccess_without_mm(), and use it in __copy_from_user_inatomic() to =
warn
> >     and refuse the copy.
> >
> >     Don't use uaccess_should_fail() there, as that would also start inj=
ecting
> >     failures into __copy_from_user_inatomic(), which some callers don't
> >     expect to fail in practice, e.g. __wp_page_copy_user() warns if the=
 copy
> >     fails twice.
> >
> >     copy_from_user_nofault() already fails quietly when current->mm is =
NULL,
> >     and the generic user stack unwinding entry points (perf_callchain()=
,
> >     get_perf_callchain() and stack_trace_save_user()) only unwind the u=
ser
> >     stack of a user task with an mm, so neither is affected.
> >
> >     Signed-off-by: James Houghton <jthoughton@google.com>
>
> The changelog names kvm_read_guest_atomic() as a user of
> __copy_from_user_inatomic(), but that function no longer exists in this t=
ree.
> It was removed by commit ef82eddc0e31 ("KVM: Remove kvm_read_guest_atomic=
()").
>
> The KVM user is now kvm_vcpu_read_guest_atomic() in virt/kvm/kvm_main.c,
> which calls the static __kvm_read_guest_atomic():
>
>     static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_=
t gfn,
>                                        void *data, int offset, unsigned l=
ong len)
>     {
>         ...
>         pagefault_disable();
>         r =3D __copy_from_user_inatomic(data, (void __user *)addr + offse=
t, len);
>         pagefault_enable();
>
> A grep for kvm_read_guest_atomic only finds __kvm_read_guest_atomic() and
> kvm_vcpu_read_guest_atomic().
>
> Could the changelog say kvm_vcpu_read_guest_atomic() instead?

Yes, that is correct. I've applied this fix in v2.
